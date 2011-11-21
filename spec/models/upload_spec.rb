require 'spec_helper'
require 'rails_spec_helper'

describe Upload do
  it 'should respond to new and allow attribute assignment' do
    Upload.new(:upload_s3_key => 'foo/bar.png').should be_valid
  end

  context 'when assigning s3 parameters to the attachment' do
    let(:upload) { Upload.new }

    it 'should respond to upload=' do
      upload.upload = {}
    end

    it 'should raise argument error with invalid keys' do
      expect { upload.upload = {:junk => 'foo'} }.to raise_error(ArgumentError)
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
