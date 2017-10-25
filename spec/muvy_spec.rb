require "spec_helper"

RSpec.describe Muvy do
  describe "version check" do
    it "has a version number" do
      expect(Muvy::VERSION).not_to be nil
    end
  end

  describe "initial argument checks" do
    it 'should raise exception and exit if it had no input' do
      expect { Muvy::CLI.new.start }.to raise_error(SystemExit)
    end

    it 'should print usage & err to stderr after exiting with no input' do
      expect do
        begin Muvy::CLI.new.start
        rescue SystemExit
        end
      end.to output(/Muvy::Errors::NoMediaInput/).to_stderr
    end

    # https://stackoverflow.com/questions/1480537/how-can-i-validate-exits-and-aborts-in-rspec
    # it 'should raise exception if it had invalid input' do
    #   expect { Muvy::CLI.new.start }.to raise_error(SystemExit)
    # end

    before do
      suppress_log_output
    end
  end

  # TODO:
  # 'complain about invalid input'
  # 'complain about invalid option'
  # 'make and delete a temporary directory'
  # 'set path to pwd if no --path given'
  # 'create instance of Download if input is URL'
  # 'create instance of Video if input is video'
  # 'create instance of ImageFolder if input is image folder'
  # 'exit on invalid URL'
  # 'exit on invalid local file'
  # 'exit on invalid folder path'
  # 'downloads youtube video'
  # 'youtube video has 480px height with format 135'
  # 'downloading creates instance of Video'
  # 'add :fps and :media_length to options hash in Video#add_options'
  # 'reads duration of local video file
  # 'reads fps of local video file
  # 'create thumbnails in Video#thumbs'
  # 'reads an image folder into an array'
  # 'montage images in date order'
  # 'default image folder montage output height is 720px (--style solid)'
  # 'exit if input image folder, --style stretch, but --height absent'
  # 'create final image in --path'
  # 'resize an image to --height'
  # 'apply gradient to image file'
  # 'rotate an image (reverses WxH)'
  # 'rotate an image with a gradient applied'
  # 'prints image statistics to stdout'
  # 'prints only image statistics when no video given'
  # 'prints video statistics to stdout when video given'
end
