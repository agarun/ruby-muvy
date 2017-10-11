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

      # TODO: Programatically trigger the methods based on options `nil` status
      resize(image)
      gradient(image)
      rotate(image)
      arc
    end

    # Arbitrary default height 720
    def resize(image)
      if options[:style] != "stretch"
        image.resize "#{image.width}x#{options[:height] ||= 720}!"
      elsif options[:height] # and style is stretch
        image.resize "#{image.width}x#{options[:height]}!"
      end
    end

    def gradient(image)
      if options[:gradient]
        choice = options[:gradient].split(":")
        choice_path = "#{options[:tmp_dir]}/muvy-gradient.png"

        weights = {
          "heavy" => 1.6,
          "medium" => 0.9,
          "light" => 0.5
        }

        MiniMagick::Tool::Convert.new do |cmd|
          cmd.size("#{image.width}x#{image.height}")
          cmd << "gradient:"
          cmd << "-function" << "Polynomial" << "-4,4,.1"
          cmd << "-evaluate" << "Pow" << weights[choice[1]]
          cmd.negate unless choice[0] == "white"
          cmd.stack do |stack|
            stack.merge! ["+clone", "-fill", "Black", "-colorize", "100"]
          end
          cmd << "+swap"
          cmd << "-alpha" << "Off"
          cmd.compose("CopyOpacity")
          cmd << "-composite"
          cmd.negate unless choice[0] == "black"
          cmd << choice_path
        end

        gradient_image = MiniMagick::Image.new(choice_path)
        apply_gradient = image.composite(gradient_image) do |composite|
          composite.compose "Over"
        end

        apply_gradient.write(options[:img])
      end
    end

    def rotate(image)
      image.rotate(90) if options[:rotate]
    end

    def arc
      MiniMagick::Tool::Convert.new do |cmd|
        cmd << options[:img]
        cmd << "-gravity" << "center"
        cmd << "+repage"
        cmd << "-virtual-pixel" << "Transparent"
        cmd << "-distort" << "Arc" << "366"
        cmd << options[:img]
      end
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
