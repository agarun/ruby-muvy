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
          p photo
          convert << photo
          # TODO: Not currently supporting `stretch` style (1x1 is solid)
          # TODO: Will have to fix the height smartly.
          convert.resize("1x1")
          convert << "#{options[:tmp_dir]}/muvy-img-folder/thumb#{i.to_s.rjust(6, '0')}.png"
        end
      end
    end

    def send_thumbs
      Image.new("#{options[:tmp_dir]}/muvy-img-folder", options).run
    end
  end
end
