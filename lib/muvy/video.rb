require 'streamio-ffmpeg'

module Muvy
  class Video
    attr_reader :media, :options, :settings, :vid

    def initialize(media, options = {})
      @media = media
      @options = options
      @settings = merge_settings
    end

    def run
      @vid = FFMPEG::Movie.new(media)
      thumbs
      # send_thumbs
    end

    # defaults holds default values
    # options holds command-line arguments
    # settings merges defaults with options where appropriate
    def merge_settings
      defaults = {
        vframes: options[:fps] * options[:media_length],
        frame_rate: options[:fps] / Math.sqrt(options[:media_length]),
        custom: %W[scale=1:#{options[:style] == 'stretch' ? 480 : 1}]
      }

      @settings = defaults.merge!(options.select { |k| defaults.key?(k) })
    end

    def thumbs
      vid.screenshot(
        "#{options[:tmp_path]}thumb%d.png",
        settings,
        validate: false
      )
    end

    def send_thumbs
      Image.new()
    ensure
      FileUtils.remove_dir(File.dirname(options[:tmp_path]))
    end
  end
end
