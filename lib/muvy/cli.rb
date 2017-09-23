require 'slop'
require 'muvy/media'
require 'muvy/errors'

module Muvy
  class CLI
    attr_reader :media, :options

    def initialize
      parse
      handle_media
      send_media
    end

    def parse
      @options = Slop.parse do |o|
        o.banner = "Usage: muvy [media link or file path] [options]"

        o.separator ""
        o.separator "Optional adjustments:"
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
      raise Muvy::Errors::NoMediaInput if options.arguments.empty?
      # raise Muvy::Errors::InvalidPathOption unless path_exists?(options[:path])
      @media = options.arguments.shift
    end

    def send_media
      Media.new(media, options)
      # Media.send
    rescue Muvy::Errors::InvalidMediaInput
      puts "Media is unrecognized. Did you forget a valid URL or file?\n\n#{options}"
    end

    private

    def path_exists?(path)
      if options[:path]
        File.directory?(path)
      else
        # No path was given, set to nil & announce path
      end
    end
  end
end
