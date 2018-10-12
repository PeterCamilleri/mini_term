# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mini_term/version"

Gem::Specification.new do |spec|
  spec.name          = "mini_term"
  spec.version       = MiniTerm::VERSION
  spec.authors       = ["PeterCamilleri"]
  spec.email         = ["peter.c.camilleri@gmail.com"]
  spec.homepage      = "https://github.com/PeterCamilleri/mini_term"

  spec.summary       = %q{A portable encapsulation of the console terminal.}
  spec.description   = %q{A portable encapsulation of the console terminal. } +
                       %q{Supports Linux, Mac, Windows, and Cygwin. }
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|docs)/})
  end

  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>=1.9.3'

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency 'minitest_visible', "~> 0.1"
  spec.add_development_dependency 'reek', "~> 5.0.2"
end
