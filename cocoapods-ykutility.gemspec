# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cocoapods-ykutility/gem_version.rb'

Gem::Specification.new do |spec|
  spec.name          = 'cocoapods-ykutility'
  spec.version       = CocoapodsYkPodUtility::VERSION
  spec.authors       = ['stephen.chen']
  spec.email         = ['stephenchen@yeahka.com']
  spec.description   = %q{A short description of cocoapods-ykutility.}
  spec.summary       = %q{A longer description of cocoapods-ykutility.}
  spec.homepage      = 'https://github.com/EXAMPLE/cocoapods-yk-pod-utility'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*', 'podTemplate/**/*', 'podTemplate/**/.gitkeep']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end