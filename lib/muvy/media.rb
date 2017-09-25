require 'muvy/download'
require 'muvy/video'
require 'muvy/errors'
require 'uri'

module Muvy
  class Media
    attr_reader :media, :options, :type

    def initialize(media, options)
      @media = media
      @options = options
      get_type
      send_type
    end

    private

    def send_type
      Muvy.const_get(type.to_s).new(media, options)
    end

    # Checks the first argument (store in :media, access via getter).
    # Determines if it should be read by Download (type - online URL)
    # or by Video (type - local media).
    # Unrecognized inputs invoke the usage heredocs and banners at `CLI`
    def get_type
      if valid_url?(media)
        @type = :Download
      elsif file_exists?(media)
        @type = :Video
      elsif path_exists?(media)
        # @ type = :Image
      else
        raise Muvy::Errors::InvalidMediaInput, "You didn't specify a URL or file."
      end
    end

    def path_exists?(path)
      full_path = File.absolute_path(path)
      File.directory?(full_path)
    end

    def file_exists?(file)
      file_path = File.absolute_path(file)
      File.file?(file_path)
    end

    # Accepts a string that behaves like a URL.
    # The URL must have a valid URI scheme (e.g. http) to differentiate
    # it from file paths. URI doesn't recognize #host without it.
    def valid_url?(url)
      encoded_url = URI.escape(url)
      parsed_url = URI.parse(encoded_url)
      !parsed_url.host.nil?
    end
  end
end
