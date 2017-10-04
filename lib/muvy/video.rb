require 'streamio-ffmpeg'
require 'muvy/image'

module Muvy
  class Video
    # TODO: Add constant to replace 480 as `NATIVE_HEIGHT`

    attr_reader :media, :options, :settings, :vid

    def initialize(media, options = {})
      @media = media
      @options = options
      @settings = merge_settings
    end

    # TODO: Clean this up.
    def run
      @vid = FFMPEG::Movie.new(media)
      thumbs
      send_thumbs
    end

    # defaults holds default values
    # options holds command-line arguments
    # settings merges defaults with options where appropriate
    def merge_settings
      defaults = {
        vframes: options[:fps] * options[:media_length],
        frame_rate: options[:fps] / (options[:media_length]**(1 / 1.99)),
        custom: %W{
          -vf scale=1:#{options[:style] == 'stretch' ? 480 : 1}
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
