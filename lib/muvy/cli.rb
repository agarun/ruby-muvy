require 'muvy/media'
require 'muvy/errors'
require 'slop'

module Muvy
  class CLI
    attr_reader :media, :options

    def start
      parse
      handle_media
      handle_path if options[:path]
      read_media
    end

    # NOTE: Slop doesn't check argument types
    def parse
      @options = Slop.parse do |o|
        o.banner = "Usage: muvy [media link, file, or file path] [options]"

        o.separator ""
        o.separator "Optional adjustments:"
        o.string  "-p", "--path", "Directory to save final images, " +
                  "\n\t\t\tDefault (PWD): #{Dir.pwd}", default: Dir.pwd
        o.string  "-s", "--style", "Choose image style: solid, stretch " +
                  "spotmap (TODO). Default: solid", default: "solid"
        o.integer "-w", "--width", "Width of the final image"
        o.integer "-h", "--height", "Height of the final image"
        o.boolean "-r", "--rotate", "Rotate final image → horizontal lines"

        o.separator ""
        o.separator "More:"
        o.on "--help", "Shows this usage page" do
          puts o
          exit
        end

        o.on "-v", "--version", "Displays the version" do
          puts "muvy version #{VERSION}"
          exit
        end

        o.separator ""
        o.separator "Example:"
      end
    rescue Slop::Error => e
      abort <<~ERROR
        #{e}.
        Type `muvy -h` to see options, or visit the
        github repo for extensive usage examples.
      ERROR
    end

    private

    def handle_media
      @media = options.arguments.shift
      raise Muvy::Errors::NoMediaInput if media.nil?
    rescue => e
      abort input_error(e)
    end

    # if --path was specified but is invalid, raise an error.
    # if --path was not specified, it will be set to the pwd
    def handle_path
      raise Muvy::Errors::InvalidPathOption unless File.directory?(options[:path])
    rescue => e
      abort "#{e}: You specified a non-existent path '#{options[:path]}'"
    end

    def read_media
      Media.new(media, options).run
    rescue => e
      abort media_error(e)
    end

    def input_error(e)
      <<~INPUT_ERROR
        #{e}
        You forgot to enter a URL, file, or folder with images.

        #{options}
      INPUT_ERROR
    end

    def media_error(e)
      <<~MEDIA_ERROR
        #{e}
        Media is unrecognized.
        The input was not a valid URL, file, or folder with images.

        #{options}
      MEDIA_ERROR
    end
  end
end
