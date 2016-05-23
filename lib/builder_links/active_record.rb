require 'active_record'

module BuilderLinks
  module ActiveRecord
    extend ActiveSupport::Concern

    module ClassMethods
      def builder_links
        define_method 'builder_links' do |arg|
          return false if arg.blank?
          return false unless attributes.include?(arg.to_s)

          analize = BuilderLinks::Analize.new(attributes[arg.to_s])
          analize.run
        end  
      end
    end
  end
end

ActiveRecord::Base.send(:include, BuilderLinks::ActiveRecord)
