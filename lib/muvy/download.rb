# frozen_string_literal: true

require 'youtube-dl.rb'

module Muvy
  class Download
    attr_reader :media, :options, :settings

    def initialize(media, options = {})
      @media = media
      @options = options.to_hash
      @settings = merge_settings
    end

    def run
      download_video
      send_video
    end

    def download_video
      vid = YoutubeDL.download(media, settings)
      add_options(vid)

      puts <<~DOWNLOADED
        Download complete.
        Video title: #{vid.information[:title]}
        Video URL: #{vid.information[:webpage_url]}
        Video format: #{vid.information[:format]} saved as #{vid.information[:ext]}
          as #{vid.information[:_filename]}
        File size: #{(vid.information[:filesize] / 1.024e6).round(2)} MB.
      DOWNLOADED
    end

    # Add important settings to @options hash for use by FFmpeg
    def add_options(vid)
      options[:fps] = vid.information[:fps]
      options[:media_length] = vid.information[:duration]
      options[:tmp_path] = options[:path] + "/tmp/muvy_video/"
    end

    def send_video
      Video.new(settings[:output], options).run if File.exists?(settings[:output])
    rescue => e
      puts e
    ensure
      FileUtils.remove_dir(File.dirname(settings[:output]))
    end

    # defaults holds default values
    # options holds command-line arguments
    # settings merges defaults with options where appropriate
    def merge_settings
      defaults = {
        continue: false,
        format: 135,
        output: options[:path] +
                "/tmp/muvy_video/" +
                Time.now.strftime("%d_%m_%Y_%H%M%S") +
                ".mp4"
      }

      @settings = defaults.merge!(options.select { |k| defaults.key?(k) })
    end
  end
end
