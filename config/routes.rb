Rails.application.routes.draw do

  root 'broadcasts#index'
  resources :viewers, only: [:index, :show]
  resources :streams, only: [:index, :show]

end
