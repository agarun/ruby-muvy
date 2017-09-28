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
      screenshots
      clean
    end

    # defaults holds default values
    # options holds command-line arguments
    # settings merges defaults with options where appropriate
    def merge_settings
      defaults = {
        vframes: options[:fps] * options[:media_length],
        frame_rate: options[:fps] / Math.sqrt(options[:media_length])
      }

      @settings = defaults.merge!(options.select { |k| defaults.key?(k) })
    end

    def screenshots
      vid.screenshot("#{options[:path]}humb%d.png", settings, validate: false)
    end

    def clean
      FileUtils.remove_dir(File.dirname(options[:path]))
    end
  end
end
