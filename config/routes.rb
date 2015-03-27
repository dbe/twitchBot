Rails.application.routes.draw do
  root 'viewers#index'
  resources :viewers, only: [:index, :show]

end
