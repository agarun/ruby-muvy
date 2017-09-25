require 'muvy/media'
require 'muvy/errors'
require 'slop'

module Muvy
  class CLI
    attr_reader :media, :options

    def initialize
      parse
      handle_media
      handle_path if options[:path]
      read_media
    end

    def parse
      @options = Slop.parse do |o|
        o.banner = "Usage: muvy [media link or file path] [options]"

        # TODO: Slop doesn't check argument types
        o.separator ""
        o.separator "Optional adjustments:"
        o.string  "-p", "--path", "Directory to save final images, default: pwd"
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

    def handle_media
      @media = options.arguments.shift
      raise Muvy::Errors::NoMediaInput if media.nil?
    rescue => e
      abort <<~INPUT_ERROR
        #{e}
        You forgot to enter a URL, file, or folder with images.

        #{options}
      INPUT_ERROR
    end

    def read_media
      Media.new(media, options)
    rescue => e
      abort <<~MEDIA_ERROR
        #{e}
        Media is unrecognized.
        The input was not a valid URL, file, or folder with images.

        #{options}
      MEDIA_ERROR
    end

    private

    # if --path was specified but is invalid, raise an error.
    # if --path was not specified, it will be set to the present working
    # directory when defaults are merged with options
    def handle_path
      raise Muvy::Errors::InvalidPathOption unless File.directory?(options[:path])
    rescue => e
      abort "#{e}: You specified a non-existent path '#{options[:path]}'"
    end
  end
end
