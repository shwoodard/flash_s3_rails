require 'rails'

module FlashS3
  class Engine < ::Rails::Engine
    config.flash_s3 = ActiveSupport::OrderedOptions.new

    initializer 'flash_s3.insert_into_active_record' do
      ActiveSupport.on_load :active_record do
        ::ActiveRecord::Base.send(:include, Rails::ActiveRecord)
      end
    end
  end
end
