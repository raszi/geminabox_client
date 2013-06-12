# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'geminabox_client/version'

Gem::Specification.new do |spec|
  spec.name          = "geminabox_client"
  spec.version       = GeminaboxClient::VERSION
  spec.authors       = ["István Karaszi"]
  spec.email         = ["github@spam.raszi.hu"]
  spec.description   = %q{Geminabox client}
  spec.summary       = %q{Client for a Geminabox project}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency "httpclient", ">= 2.2.7"
end
