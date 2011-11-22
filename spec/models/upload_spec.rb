require 'spec_helper'
require 'rails_spec_helper'

describe Upload do
  context 'when declaring an s3_upload' do
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
end
