require 'muvy/media'
require 'muvy/errors'
require 'slop'

module Muvy
  class CLI
    attr_reader :media, :options

    def initialize
      parse
      handle_path
      handle_media
      read_media
    end

    def parse
      @options = Slop.parse do |o|
        o.banner = "Usage: muvy [media link or file path] [options]"

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
      puts "No path specified, final image will be saved to #{Dir.pwd}"
      abort "You didn't specify a URL or file." if media.nil?
    end

    def read_media
      Media.new(media, options)
    rescue Muvy::Errors::InvalidMediaInput
      puts "Media is unrecognized. Did you forget a valid URL or file?" +
           "\n\n#{options}"
    end

    def handle_path
      # if --path doesn't exist, it should be set to PWD.
      # display warning
      # or... raise Muvy::Errors::InvalidPathOption
    end
  end
end
