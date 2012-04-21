FlashS3Test::Application.routes.draw do
  resources :uploads, :only => [:new, :create]
  root :to => "uploads#new"
end
