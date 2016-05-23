require 'builder_links/version'
require 'builder_links/config'
require 'builder_links/analize'
require 'builder_links/active_record'

module BuilderLinks
  extend Config

  define_setting :patterns
  define_setting :keyword_links
  define_setting :total_links
  @patterns = []
  @patterns.reverse!
  @keyword_links = nil
  @total_links = nil

  def self.setup(&block)
    yield self
  end

  def self.text(text)
    analize = BuilderLinks::Analize.new(text)
    analize.run
  end

  def self.logger
    @@logger ||= defined?(Rails) ? Rails.logger : Logger.new(STDOUT)
  end

  def self.logger=(logger)
    @@logger = logger
  end
end
