require "active_support"
require "flash_s3/version"
require "flash_s3/engine"

module FlashS3
  extend ActiveSupport::Autoload

  autoload :AttachmentDefinition
  autoload :Attachment

  class << self
    def configure
      yield(configuration)
    end

    def configuration
      ::Rails.application.railties.engines.find {|engine| engine.is_a? FlashS3::Engine }.config.flash_s3
    end
  end

  module Rails
    module ActiveRecord
      extend ActiveSupport::Concern

      module ClassMethods
        def has_attached_s3_file(name, &blk)
          name = name.to_sym
          attachment_definition = AttachmentDefinition.new(name)

          if block_given?
            attachment_definition.configure(&blk)
          end

          unless respond_to?(:s3_file_attachment_definitions)
            cattr_accessor :s3_file_attachment_definitions
            self.s3_file_attachment_definitions = {}
          end

          s3_file_attachment_definitions[name] = attachment_definition

          define_method :"#{name}=" do |options|
            options.assert_valid_keys(:s3_key)
            send(:"#{name}_s3_key=", options[:s3_key])
          end

          define_method :"#{name}" do
            Attachment.new(name, self.class.s3_file_attachment_definitions[name], self)
          end

          before_save :persist_flash_s3_attachment_meta_data, :if => lambda {|record| record.flash_s3_meta_data_changed?(name) }
        end
      end

      module InstanceMethods
        def persist_flash_s3_attachment_meta_data
          # hook here to do something ???
          true
        end

        def flash_s3_meta_data_changed?(name)
          return false unless self.class.s3_file_attachment_definitions.has_key?(name)
          send(:"#{name}_s3_key_changed?")
        end
      end
    end
  end
end
