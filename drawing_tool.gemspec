# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'drawing_tool/version'

Gem::Specification.new do |spec|
  spec.name          = 'drawing_tool'
  spec.version       = DrawingTool::VERSION
  spec.authors       = ['Christian Rojas']
  spec.email         = ['christianrojasgar@gmail.com']
  spec.summary       = %q{Drawing Tool - Coding Challenge.}
  spec.description   = %q{Simple console version of a drawing program.}
  spec.homepage      = 'https://github.com/christianrojas/drawing_tool'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'terminal-table', '~> 1.4.5'
  spec.add_dependency 'thor', '~> 0.19.1'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.2.0'
end
