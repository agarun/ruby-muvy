require 'uri'
require 'muvy/download'
require 'muvy/video'

module Muvy
  class CLI
    attr_reader :file, :options

    def initialize(arguments)
      @file = arguments.shift
      @options = *arguments
    end

    private

    def valid_url?(url)
      encoded_url = URI.escape(url)
      parsed_url = URI.parse(encoded_url)
      parsed_url.host.nil?
    end
  end
end
