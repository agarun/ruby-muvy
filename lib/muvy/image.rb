require "mini_magick"

module Muvy
  class Image
    attr_reader :media, :options

    def initialize(media, options)
      @media = media
      @options = options
    end

    def run
      montage
      resize if options[:style] == "solid"
    end

    def montage
      MiniMagick::Tool::Montage.new do |montage|
        montage << (media + "thumb*.png")
        montage.mode("Concatenate")
        montage.tile("x1")
        options[:img] =
          File.absolute_path(options[:path]) +
          "/muvy-" +
          Time.now.strftime('%d-%m-%H%M%S') +
          ".png"
        montage << options[:img]
      end
    end

    def resize
      img = MiniMagick::Image.new(options[:img])
      img.resize "#{img.width}x#{options[:height]}!"
    end

    def dominant_colors
      # Colors class
      # must generate full thumbnails in custom: %w() if -dominant is chosen
      # then extract all the colors, and calculate via algorithms
      # pixels = image.get_pixels
    end
  end
end
