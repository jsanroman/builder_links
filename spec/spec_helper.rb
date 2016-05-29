begin
  # Test coverage reporters
  require 'codeclimate-test-reporter'
  CodeClimate::TestReporter.start
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new [
    SimpleCov::Formatter::HTMLFormatter,
    CodeClimate::TestReporter::Formatter
  ]
  SimpleCov.start
rescue LoadError
  puts 'Codeclimate Test Reporter not installed. '\
  'Install gem codeclimate-test-reporter for coverage data.'
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'builder_links'
