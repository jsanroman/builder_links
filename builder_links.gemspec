# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'builder_links/version'

Gem::Specification.new do |spec|
  spec.name          = 'builder_links'
  spec.version       = BuilderLinks::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 1.9'

  spec.licenses      = ["MIT"]
  spec.authors       = ["Javi Sanromán"]
  spec.email         = ["javisanroman@gmail.com"]

  spec.summary       = %q{Ruby gem to generated links automatically based in a text, keywords and urls given}
  spec.description   = %q{Ruby gem to generated links automatically based in a text, keywords and urls given}
  spec.homepage      = 'https://github.com/jsanroman/builder_links'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'activerecord'#, '~> 10.0'
  spec.add_development_dependency 'nokogiri'#, '~> 10.0'
end