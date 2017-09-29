require 'streamio-ffmpeg'
require 'muvy/image'

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
      send_thumbs
    end

    # defaults holds default values
    # options holds command-line arguments
    # settings merges defaults with options where appropriate
    def merge_settings
      defaults = {
        vframes: options[:fps] * options[:media_length],
        frame_rate: options[:fps] / (options[:media_length]**(1 / 1.91)),
        custom: %W[-vf scale=1:#{options[:style] == 'stretch' ? 480 : 1}]
      }

      @settings = defaults.merge!(options.select { |k| defaults.key?(k) })
    end

    def thumbs
      vid.screenshot(
        "#{options[:tmp_path]}thumb%06d.png",
        settings,
        validate: false
      )
    end

    def send_thumbs
      puts "x"
      Image.new(options[:tmp_path], options).run
      puts "y"
    ensure
      FileUtils.remove_dir(File.dirname(options[:tmp_path]))
    end
  end
end
