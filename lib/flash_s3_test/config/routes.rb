FlashS3Test::Application.routes.draw do
  resources :uploads, :only => :new
  root :to => "uploads#new"
end
