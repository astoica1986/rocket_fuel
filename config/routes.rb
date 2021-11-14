Rails.application.routes.draw do
  resources :planets
  root to: 'planets#index'
end
