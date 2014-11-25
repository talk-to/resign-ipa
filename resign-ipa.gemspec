# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'resign/ipa/version'

Gem::Specification.new do |spec|
  spec.name          = 'resign-ipa'
  spec.version       = '0.0.2'
  spec.authors       = ['Talk.to']
  spec.email         = ['chaitanya.g@directi.com']
  spec.summary       = %q{Resign an IPA to modify the provisioning profile.}
  spec.homepage      = 'https://github.com/talk-to/resign-ipa'
  spec.license       = 'COMMERCIAL'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
