# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yaml_editor/version'

Gem::Specification.new do |spec|
  spec.name          = 'yaml_editor'
  spec.version       = YamlEditor::VERSION
  spec.authors       = ['Andrey Ponomarenko']
  spec.email         = ['andrei.panamarenka@gmail.com']

  spec.summary       = ' Edit yaml files with saving anchors '
  spec.description   = ' Edit yaml files with saving anchors '
  spec.homepage      = 'https://github.com/sjke/yaml_editor'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'

  spec.add_dependency 'psych', '~> 2.1'
end
