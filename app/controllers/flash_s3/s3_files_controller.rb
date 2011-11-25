class FlashS3::S3FilesController < ApplicationController
  def create
    record = params[:s3_file_class].constantize.new(params[params[:s3_file_class].underscore.downcase])
    saved = record.save
    render :json => record.to_json(:methods => [:errors]), :status => saved ? 200 : 422
  end
end
