require 'streamio-ffmpeg'

module Muvy
  class Video

    attr_reader :media, :options

    def initialize(media, options = {})
      @media = media
      @options = options
      puts "I'm testing that this works properly (Video)"
    end
  end
end
