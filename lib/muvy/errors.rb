module Muvy
  module Errors
    class InvalidMediaInput < RuntimeError; end

    class NoMediaInput < ArgumentError; end
  end
end
