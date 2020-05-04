Rails.application.routes.draw do
  get 'offline', to: 'home#offline'
  get 'manifest', to: 'home#manifest'
  
  ActiveAdmin.routes(self)
  
  devise_for :users, controllers: { registrations: 'registrations' }
  
  resources :profile
  
  get "/*id", to: 'users#show', constraints: { id: %r{[^/]+} }, as: :user
  
  root to: 'home#index'
end
