# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ucloud_api/version'

Gem::Specification.new do |spec|
  spec.name          = "ucloud_api"
  spec.version       = UcloudApi::VERSION
  spec.authors       = ["BJ Kim"]
  spec.email         = ["burnssun@gmail.com"]
  spec.summary       = %q{KT ucloud biz api}
  spec.description   = %q{KT ucloud biz api}
  spec.homepage      = 'https://github.com/burnsssun/ucloud_api'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
