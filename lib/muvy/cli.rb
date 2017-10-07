require 'muvy/media'
require 'muvy/errors'
require 'slop'

module Muvy
  class CLI
    attr_reader :media, :options

    def start
      parse
      handle_media
      handle_path
      convert_options
      read_media
    end

    def parse
      @options = Slop.parse do |o|
        o.banner = "Usage: muvy [media link, file, or file path] [options]"

        o.separator ""
        o.separator "Optional adjustments:"
        o.string  "-p", "--path", "Directory to save final images, " +
                  "\n\t\t\tDefault: your pwd → #{Dir.pwd}",
                  default: Dir.pwd
        o.string  "-s", "--style", "Choose image style: solid, stretch " +
                  "\n\t\t\tDefault: solid",
                  default: "solid"
        o.boolean "-r", "--rotate", "Image will have horizontal lines"
        o.integer "-h", "--height", "Custom height of the final image"
        o.string "--start", "Custom video start time"
        o.string "--end", "Custom video end time"
        o.string "--format", "Force youtube-dl to use a specific video quality"
        o.string "--frame_rate", <<~FPS
          Set a custom frame rate. Be careful!
          \t\t\s\s\sSetting this to a high number might cause hundreds of
          \t\t\s\s\sthousands of images to be generated in your sytem's temp dir.
          \t\t\s\s\sThe specific frame_rate used by default for your file is printed
          \t\t\s\s\safter generation. You can use that number to make a reasonable change.
        FPS

        o.separator "More:"
        o.on "--help", "Shows this usage page" do
          abort o.to_s
        end

        o.on "-v", "--version", "Displays the version" do
          abort "muvy version #{VERSION}"
        end
      end
    rescue Slop::Error => e
      abort <<~ERROR
        #{e}.
        Type `muvy --help` to see options, or visit the
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

    # if -path was specified but is invalid, raise an error
    # if -path was not specified, it was set to the pwd by Slop defaults
    def handle_path
      raise Muvy::Errors::InvalidPathOption unless File.directory?(options[:path])
    rescue => e
      abort "#{e}: You specified a non-existent path '#{options[:path]}'"
    end

    # FileUtils.remove_entry_secure is called before ::mktmpdir returns
    def read_media
      Dir.mktmpdir do |tmp_dir|
        options[:tmp_dir] = tmp_dir
        puts "Using #{tmp_dir} to store jobs locally..."

        Media.new(media, options).run
      end
    rescue => e
      abort media_error(e)
    ensure
      puts "#{options[:tmp_dir]} was erased." if options[:tmp_dir]
    end

    def convert_options
      @options = options.to_hash # finalize
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
