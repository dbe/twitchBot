Rails.application.routes.draw do

  root 'broadcasts#current'

  get 'broadcasts/current', to: 'broadcasts#current', as: 'current_broadcast'
  resources :broadcasts, only: [:index, :show]

  resources :viewers, only: [:index, :show]
  resources :streams, only: [:index, :show]

end
