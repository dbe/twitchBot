Rails.application.routes.draw do
  root 'viewers#index'
  resources :viewers

end
