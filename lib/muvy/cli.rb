require 'slop'
require 'muvy/download'
require 'muvy/video'
require 'uri'

module Muvy
  class CLI
    attr_reader :media, :options

    # TODO: Exit if args are empty
    def initialize
      parse
      handle_media
      send_media
    end

    def parse
      @options = Slop.parse do |o|
        o.banner = "Usage: muvy [media link or file path] [options]"

        o.separator ""
        o.separator "Options (none are required):"
        o.string  "-p", "--path", "Directory to save final image, default: pwd"
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
      end
    rescue Slop::Error => err
      puts <<~ERROR
        Unrecognized input.
        Error: #{err}.
        Type `muvy -h` to see options, or visit the
        github repo for extensive usage examples.
      ERROR
    end

    def handle_media
      @media = options.arguments.shift
    end

    # TODO: Parameterized factory method
    # Checks the first argument (stored in :media getter) and determines
    # if it should be read by Download (web URL) or Video (local media
    # file). Unrecognized inputs invoke the usage heredocs and banners.
    def send_media
      if valid_url?(media)
        Download.new(media, options)
      elsif file_exists?(media)
        Video.new(media, options)
      else
        puts "Media is unrecognized. Did you forget a valid URL or file?"
        puts options
      end
    end

    private

    def file_exists?(file)
      file_path = File.absolute_path(file)
      File.file?(file_path)
    end

    # TODO: Merge path in options with PWD if nil
    def path_exists?(path)
      File.directory?(path)
    end

    # TODO: Rework so it doesn't depend on http* and checks validity
    # Accepts a string that behaves like a URL
    def valid_url?(url)
      encoded_url = URI.escape(url)
      parsed_url = URI.parse(encoded_url)
      !parsed_url.host.nil?
    end
  end
end
