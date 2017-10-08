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
      rotate
      printout
    end

    private

    def montage
      MiniMagick::Tool::Montage.new do |montage|
        montage << (media + "/thumb*.png")
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

    # Arbitrary default height 720
    # TODO: Refactor helper functions into classes
    def resize
      unless options[:style] == "stretch"
        img = MiniMagick::Image.new(options[:img])
        img.resize "#{img.width}x#{options[:height] ||= 720}!"
      end
    end

    def rotate
      if options[:rotate]
        img = MiniMagick::Image.new(options[:img])
        img.rotate(90)
      end
    end

    def printout
      # add image width & height
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
