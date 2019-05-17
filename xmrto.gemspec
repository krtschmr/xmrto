# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xmrto/version'

Gem::Specification.new do |spec|
  spec.name          = "xmrto"
  spec.version       = Xmrto::VERSION
  spec.authors       = ["Tim Kretschmer"]
  spec.email         = ["tim@krtschmr.de"]
  spec.description   = %q{A xmr.to api library}
  spec.summary       = %q{A xmr.to api library}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.required_rubygems_version = '>= 1.3.6'

end
