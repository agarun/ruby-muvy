# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "muvy/version"

Gem::Specification.new do |spec|
  spec.name          = "muvy"
  spec.version       = Muvy::VERSION
  spec.authors       = ["agarun"]
  spec.email         = ["19801205+agarun@users.noreply.github.com"]

  spec.summary       = "Ruby movie barcode generator."
  spec.homepage      = "https://github.com/agarun/ruby-muvy"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # spec.add_dependency "youtube-dl.rb"
  spec.add_dependency "streamio-ffmpeg", "~> 3.0.2"
  spec.add_dependency "mini_magick"
  spec.add_dependency "slop"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
