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

  spec.summary       = %q{A ruby gem to generate links automatically based on a text, keywords and urls is given}
  spec.description   = %q{A ruby gem to generate links automatically based on a text, keywords and urls is given. Useful for example to increase dinamically the internal links in your site and improve SEO metrics.}
  spec.homepage      = 'https://github.com/jsanroman/builder_links'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency 'rake', '~> 10.0'

  if ENV['TRAVIS'] == 'true' && RUBY_VERSION < '2.2.2'
    spec.add_dependency 'activesupport', '< 5'
  else
    spec.add_dependency 'activesupport'
  end
  spec.add_development_dependency 'activerecord'

  spec.add_development_dependency 'nokogiri'
end
