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
    end

    def run
      get_type
      send_type
    end

    private

    def send_type
      Muvy.const_get(type.to_s).new(media, options).run
    end

    # Checks the first argument (store in :media, access via getter).
    # Determines if it should be read by Download (type - online URL),
    # by Video (type - local media), or by Image (type - local image files).
    # Unrecognized inputs invoke the usage heredocs and banners at `CLI`
    def get_type
      if valid_url?(media)
        @type = :Download
      elsif file_exists?(media)
        @type = :Video
      elsif path_exists?(media) && image_folder?(media)
        @type = :Image # Not yet implemented.
      else
        raise Muvy::Errors::InvalidMediaInput
      end
    end

    # Accepts a string that behaves like a URL.
    # The URL must have a valid URI scheme (e.g. http) to differentiate
    # it from file paths. URI module doesn't recognize #host without it.
    def valid_url?(url)
      encoded_url = URI.escape(url)
      parsed_url = URI.parse(encoded_url)
      !parsed_url.host.nil?
    end

    def file_exists?(file)
      file_path = File.absolute_path(file)
      File.file?(file_path)
    end

    def path_exists?(path)
      full_path = File.absolute_path(path)
      File.directory?(full_path)
    end

    def image_folder?(path)
      false
    end
  end
end
