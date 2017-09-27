require "mini_magick"

module Muvy
  class Image
    attr_reader :media, :options

    # @media is a path to a folder with image files
    def initialize(media, options)
      @media = media
      @options = options
    end

    # TODO: choose image files by date created
    def run
      #
    end
  end
end
