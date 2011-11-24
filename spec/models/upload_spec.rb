require 'spec_helper'
require 'rails_spec_helper'

describe Upload do
  context 'when declaring an s3_upload without an environmental config', :without_env_config => true do
    let(:upload) { Upload.new }
  
    it 'should respond to upload=' do
      upload.upload = {}
    end

    it 'should raise argument error with invalid keys' do
      expect { upload.upload = {:junk => 'foo'} }.to raise_error(ArgumentError)
    end

    it 'the upload should be invalid' do
      upload.upload.should_not be_valid
    end

    context 'and the bucket is not defined inline' do
      it 'should not be valid if bucket is not configured globally' do
        upload.upload.should_not be_valid
      end

      it 'should be valid if the configuration is defined with the module' do
        FlashS3.configure do |config|
          config.bucket = "foo"
          config.s3_access_key_id = "bas"
          config.s3_secret_access_key = "fubar"
        end

        upload.upload = {:s3_key => 'foo/bar.png'}

        upload.upload.should be_valid
      end
    end

    context 'and the bucket is defined inline' do
      it 'the upload should be valid' do
        upload.upload_with_block = {:s3_key => 'foo/bar.png'}
        upload.upload_with_block.should be_valid
      end
    end

    context 'with a valid s3_key' do
      before do
        upload.upload = {:s3_key => 'foo/bar.png'}
      end

      it 'should assisn the s3_key' do
        upload.upload.s3_key.should == 'foo/bar.png'
      end

      it 'should save the s3_key if it has changed' do
        upload.save
        upload.upload_s3_key.should == 'foo/bar.png'
      end
    end
  end

  context 'when declaring an s3_upload with an environmental config' do
    let(:upload) { Upload.new }


    it 'should be valid if the configuration is defined from the rails environemnt configs' do
      upload.upload = {:s3_key => 'foo/bar.png'}

      upload.upload.should be_valid
      upload.upload.bucket.should == 'bas'
    end
  end
end
