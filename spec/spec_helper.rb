require 'rspec'
require 'flash_s3'

include FlashS3

RSpec.configure do |config|
  config.before(:all) do
    @original_config = ::FlashS3.configuration.dup
  end

  config.after(:each) do
    ::FlashS3.send(:configuration=, @original_config)
  end

  config.before(:each) do
    ::FlashS3.configuration.clear if example.metadata[:without_env_config] == true
  end
end
