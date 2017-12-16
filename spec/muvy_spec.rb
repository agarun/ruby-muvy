require "spec_helper"

RSpec.describe Muvy do
  describe "version check" do
    it "has a version number" do
      expect(Muvy::VERSION).not_to be nil
    end
  end

  describe "CLI" do
    describe "initial argument checks" do
      it "should raise exception and exit if it had no input" do
        expect { Muvy::CLI.new.start }.to raise_error(SystemExit)
      end

      it "should print usage & err to stderr after exiting with no input" do
        expect do
          begin Muvy::CLI.new.start
          rescue SystemExit
          end
        end.to output(/Muvy::Errors::NoMediaInput/).to_stderr
      end

      # https://stackoverflow.com/questions/1480537/how-can-i-validate-exits-and-aborts-in-rspec
      # it "should raise exception if it had invalid input" do
      #   expect { Muvy::CLI.new.start }.to raise_error(SystemExit)
      # end

      before do
        suppress_log_output
      end
    end

    it "complains about invalid input"
    it "complains about invalid option"
    it "makes a temporary directory"
    it "deletes the temporary directory"
    it "set path to pwd if no --path given"

  end

  describe "Media" do
    context "URL input" do
      it "creates instance of Download if input is URL"
      it "raises error on invalid URL"
    end

    context "Video input" do
      it "creates instance of Video if input is video"
      it "raises error on invalid local file"
    end

    context "ImageFolder input" do
      it "creates instance of ImageFolder if input is image folder"
      it "raises error on invalid folder path"
    end
  end

  describe "Download" do
    it "downloads youtube video"
    it "youtube video has 480px height with format 135 by default"
    it "downloading creates instance of Video"
  end

  describe "Video" do
    describe "#add_options" do
      it "add :fps and :media_length to options hash"
    end

    describe "#thumbs" do
      it "creates thumbnails"
    end

    it "reads duration of local video file"
    it "reads fps of local video file"
  end

  describe "ImageFolder" do
    it "reads an image folder into an array"
    it "montage images in date order"
    it "default image folder montage output height is 720px (--style solid)"
    it "exits if input image folder, --style stretch, but --height absent"
  end

  describe "Image" do
    it "creates final image in --path"
    it "resizes an image to --height"
    it "applies gradient to image file"
    it "rotate an image (reverses WxH)"
    it "rotate an image with a gradient applied"
    it "prints image statistics to stdout"
    it "prints only image statistics when no video given"
    it "prints video statistics to stdout when video given"
  end
end
