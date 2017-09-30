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
      resize
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
  end
end
