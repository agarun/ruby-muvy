# frozen_string_literal: true

require 'youtube-dl.rb'

module Muvy
  class Download
    SETTINGS = {}

    attr_reader :media, :options

    def initialize(media, options = {})
      @media = media
      @options = options
      puts "I'm testing that this works properly (Download)"
    end
  end
end
