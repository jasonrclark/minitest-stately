# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'minitest/stately/version'

Gem::Specification.new do |spec|
  spec.name          = "minitest-stately"
  spec.version       = Minitest::Stately::VERSION
  spec.authors       = ["Jason R. Clark"]
  spec.email         = ["jason@jasonrclark.net"]
  spec.summary       = %q{Find leaking state between tests}
  spec.homepage      = "http://github.com/jasonrclark/minitest-stately"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "minitest", ">= 5.0.0"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
