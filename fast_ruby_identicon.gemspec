# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fast_ruby_identicon/version'

Gem::Specification.new do |spec|
  spec.name          = "fast_ruby_identicon"
  spec.version       = FastRubyIdenticon::VERSION
  spec.authors       = ["Stanislav Ershov"]
  spec.email         = ["digital.stream.of.mind@gmail.com"]
  spec.extensions    = ["ext/fast_ruby_identicon/extconf.rb"]
  spec.summary       = %q{Fast version of ruby_identicon gem}
  spec.description   = %q{}
  spec.homepage      = "http://github.com/crackedmind/fast_ruby_identicon"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rake-compiler"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "oily_png", "~> 1.1.0"
end
