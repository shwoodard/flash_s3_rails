Rails.application.routes.draw do
  namespace :flash_s3 do
    resources :s3_files
  end
end
