require "mini_magick"

module Muvy
  class ImageFolder
    attr_reader :media, :options, :photos

    def initialize(media, options)
      @media = media
      @options = options
      @photos = add_photos
    end

    def run
      average
      send_thumbs
    end

    private

    def add_photos
      Dir.glob("#{media}/*")
    end

    def average
      # Store the average photos here
      Dir.mkdir("#{options[:tmp_dir]}/muvy-img-folder/")

      photos.each_with_index do |photo, i|
        MiniMagick::Tool::Convert.new do |convert|
          convert << photo
          convert.resize("1x#{height}!")
          convert << "#{options[:tmp_dir]}/muvy-img-folder/thumb#{i.to_s.rjust(6, '0')}.png"
        end
      end
    end

    def height
      if options[:style] == "stretch"
        options[:height] ? options[:height] : (abort <<~NO_HEIGHT)
          You specified an image folder and 'stretch' with the --style flag.
          You should also specify a uniform height with the --height option.
        NO_HEIGHT
      else
        # Arbitrary default height 720
        options[:height] ||= 720

        # 1x1 to get average colors ('solid' style)
        1
      end
    end

    def send_thumbs
      Image.new("#{options[:tmp_dir]}/muvy-img-folder", options).run
    end
  end
end
