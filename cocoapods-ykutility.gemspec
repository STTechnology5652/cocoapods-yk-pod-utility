# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cocoapods-ykutility/gem_version.rb'

Gem::Specification.new do |spec|
  spec.name          = 'cocoapods-ykutility'
  spec.version       = CocoapodsYkPodUtility::VERSION
  spec.authors       = ['stephen.chen']
  spec.email         = ['stephenchen@yeahka.com']
  spec.description   = %q{创建定制化标准组件.}
  spec.summary       = %q{一款cocoapods插件，用于创建定制化标准组件.}
  spec.homepage      = 'https://github.com/stephen5652/cocoapods-yk-pod-utility.git'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*', 'podTemplate/**/*', 'podTemplate/**/.gitkeep']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
end
