require 'slop'
require 'muvy/download'
require 'muvy/video'
require 'uri'

module Muvy
  class CLI
    attr_reader :options

    def initialize
      parse
    end

    def parse
      @options = Slop.parse do |o|
        o.banner = "Usage: muvy [media link or file path] [options]"
        o.separator ""
        o.separator "Options:"
        o.string "-p", "--path", "Directory to save final image, default is pwd"
        o.boolean "-r", "--rotate", "Rotate final image → horizontal lines"
        o.separator ""
        o.separator "More:"
        o.on "-h", "--help", "Shows usage" do
          puts o
        end
        o.on "-v", "--version", "Displays the version" do
          puts VERSION
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

    private

    def file_exists?(file)
      file_path = File.absolute_path(file)
      File.file?(file_path)
    end

    def path_exists?(path)
      File.directory?(path)
    end

    # Accepts a string that behaves like a URL
    def valid_url?(url)
      encoded_url = URI.escape(url)
      parsed_url = URI.parse(encoded_url)
      !parsed_url.host.nil?
    end
  end
end
