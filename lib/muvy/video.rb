require 'streamio-ffmpeg'
require 'muvy/image'

module Muvy
  class Video
    attr_reader :media, :options, :settings, :vid

    def initialize(media, options = {})
      @media = media
      @options = options
    end

    def run
      @vid = FFMPEG::Movie.new(media)
      @settings = merge_settings

      thumbs
      send_thumbs
    end

    private

    # Add important settings to @options hash for use by FFmpeg
    def add_options
      options[:fps] = vid.frame_rate
      options[:media_length] = vid.duration
    end

    # defaults holds default values
    # options holds command-line arguments
    # settings merges defaults with options where appropriate
    def merge_settings
      add_options

      defaults = {
        vframes: options[:fps] * options[:media_length],
        frame_rate: options[:fps] / (options[:media_length]**(1 / 1.99)),
        custom: %W{
          -vf scale=1:#{options[:style] == 'stretch' ? vid.height : 1}
          -ss #{options[:start] ? options[:start] : 0}
          -to #{options[:end] ? options[:end] : options[:media_length]}
        }
      }

      @settings = defaults.merge!(options.select { |k, v| defaults.key?(k) && v })
    end

    def thumbs
      vid.screenshot(
        "#{options[:tmp_dir]}/thumb%06d.png",
        settings,
        validate: false
      )
    end

    def send_thumbs
      Image.new(options[:tmp_dir], options).run
    end
  end
end
