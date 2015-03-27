Rails.application.routes.draw do

  root 'viewers#index'
  resources :viewers, only: [:index, :show]
  resources :streams, only: [:index, :show]

end
