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

    # it 'should raise exception if it had invalid input' do
    #   expect { Muvy::CLI.new.start }.to raise_error(SystemExit)
    # end

    before do
      suppress_log_output
    end
  end

  # TODO:
  # 'complains about invalid input'
  # 'sets path to pwd if no --path given'
  # 'Media if valid file'
  # 'ImageFolder and Image if given image folder'
  # 'Download, Video & Image if given URL'
  # 'Video and Image if given local file'
  # 'downloads youtube video'
  # 'thumbnails for any video'
  # 'files in system's temporary folder'
  # 'rotates an image'
  # 'rotates an image with a gradient applied'
  # 'a folder in Dir.pwd or --path'
  # 'image statistics to stdout'
  # 'video statistics to stdout true when video given, false when image given'
end
