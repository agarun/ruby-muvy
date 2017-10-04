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

    def parse
      @options = Slop.parse do |o|
        o.banner = "Usage: muvy [media link, file, or file path] [options]"

        o.separator ""
        o.separator "Optional adjustments:"
        o.string  "-p", "-path", "Directory to save final images, " +
                  "\n\t\t\tDefault: your pwd → #{Dir.pwd}",
                  default: Dir.pwd
        o.string  "-s", "-style", "Choose image style: solid, stretch " +
                  "\n\t\t\tDefault: solid",
                  default: "solid"
        o.boolean "-r", "-rotate", "Rotate final image → horizontal lines"
        o.integer "-h", "-height", "Custom height of the final image",
                  default: 640
        o.string "-start", "Custom video start time, if applicable."
        o.string "-end", "Custom video end time, if applicable."

        o.separator ""
        o.separator "More:"
        o.on "-help", "Shows this usage page" do
          abort o.to_s
        end

        o.on "-v", "-version", "Displays the version" do
          abort "muvy version #{VERSION}"
        end

        o.string "-frame_rate", "Set a custom frame rate. Be extremely " +
                 "careful!\n\t\t\s\sSetting this to a high number might cause hundreds of " +
                 "thousands of images to be generated.\n\t\t\s\s" +
                 "See online docs for examples of reasonable numbers."
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

    def read_media
      Media.new(media, options).run
    rescue => e
      abort media_error(e)
    end

    # if -path was specified but is invalid, raise an error.
    # if -path was not specified, it will be set to the pwd.
    def handle_path
      raise Muvy::Errors::InvalidPathOption unless File.directory?(options[:path])
    rescue => e
      abort "#{e}: You specified a non-existent path '#{options[:path]}'"
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
