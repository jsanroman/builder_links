require 'active_record'

module BuilderLinks
  module ActiveRecord
    extend ActiveSupport::Concern

    module ClassMethods
      def builder_links
        define_method 'builder_links' do |attr, opts={}|
          return false if attr.blank?
          return false unless attributes.include?(attr.to_s)

          analize = BuilderLinks::Analize.new(attributes[attr.to_s], opts)
          analize.run
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, BuilderLinks::ActiveRecord)
