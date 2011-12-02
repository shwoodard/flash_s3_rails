class UploadsController < ApplicationController
  def new
    @upload = Upload.new
  end
end
