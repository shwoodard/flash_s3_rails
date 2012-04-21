class UploadsController < ApplicationController
  def new
    @upload = Upload.new
  end

  def create
    head :ok
  end
end
