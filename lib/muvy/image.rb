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
      modification
      printout
    end

    private

    def montage
      MiniMagick::Tool::Montage.new do |montage|
        montage << "#{media}/thumb*.png"
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

    def modification
      image = MiniMagick::Image.new(options[:img])

      resize(image)
      rotate(image)
    end

    # Arbitrary default height 720
    def resize(image)
      if options[:style] != "stretch"
        image.resize "#{image.width}x#{options[:height] ||= 720}!"
      elsif options[:height] # and style is stretch
        image.resize "#{image.width}x#{options[:height]}!"
      end
    end

    def rotate(image)
      image.rotate(90) if options[:rotate]
    end

    def printout
      # TODO: add image width & height
      puts "Saved to #{options[:img]}."
      puts <<~PRINTOUT if options[:fps]

        Thumbnails made at #{options[:frame_rate] ? options[:frame_rate] : (options[:fps] / (options[:media_length]**(1 / 1.99))).round(4) } frames per second.
        Original video duration was #{options[:media_length]}.
        #{'Start time: ' + options[:start].to_s if options[:start]}
        #{'End time: ' + options[:end].to_s if options[:end]}
      PRINTOUT
    end
  end
end
