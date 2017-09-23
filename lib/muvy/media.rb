require 'muvy/download'
require 'muvy/video'
require 'muvy/errors'

module Muvy
  class Media
    attr_reader :media, :options, :type

    # Parameterized class method in factory class
    def self.send
      case type
      when :online
        Download.new(media, options)
      when :local
        Video.new(media, options)
      end
    end

    def initialize(media, options)
      @media = media
      @options = options
      get_type
    end

    # Checks the first argument (stored in :media, access via getter).
    # Determines if it should be read by Download (type - online URL)
    # or by Video (type - local media).
    # Unrecognized inputs invoke the usage heredocs and banners at `CLI`
    def get_type
      if valid_url?(media)
        @type = :online
      elsif file_exists?(media)
        @type = :local
      else
        raise Muvy::Errors::InvalidMediaInput
      end
    end

    private

    def file_exists?(file)
      file_path = File.absolute_path(file)
      File.file?(file_path)
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
