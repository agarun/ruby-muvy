# frozen_string_literal: true

require 'youtube-dl.rb'

module Muvy
  class Download
    SETTINGS = {
      continue: false,
      format: :worstvideo,
      output: "#{Dir.pwd}/tmp/ruby-muvy_video_downloads"
    }

    attr_reader :media, :options

    def initialize(media, options = {})
      @media = media
      @options = SETTINGS.merge(options.to_hash)
    end

    def run
      # download_video
      # send_video
      puts "Download - test"
    end

    def download_video
      YoutubeDL.download(video_url, options)
    end

    def send_video
      #
    end
  end
end
