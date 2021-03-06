Rails.application.routes.draw do

  root 'broadcasts#current'

  get 'broadcasts/current', to: 'broadcasts#current', as: 'current_broadcast'
  resources :broadcasts, only: [:index, :show]

  resources :viewers, only: [:index, :show] do
    resources :broadcasts, only: [:index]
  end

  resources :streams, only: [:index, :show]
end
