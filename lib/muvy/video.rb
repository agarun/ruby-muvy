require 'streamio-ffmpeg'

module Muvy
  class Video
    DEFAULTS = {}

    attr_reader :media, :options

    def initialize(media, options = {})
      @media = media
      @options = options
    end

    def run
      puts "Video - test"
    end
  end
end
