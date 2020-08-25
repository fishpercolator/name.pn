Rails.application.routes.draw do
  get 'offline', to: 'home#offline'
  get 'manifest', to: 'home#manifest'
  
  ActiveAdmin.routes(self)
  
  devise_for :users, controllers: { registrations: 'registrations' }
  
  resources :profile
  
  get "/:id(/:nominative/:oblique)", to: 'users#show', constraints: { id: %r{[^/]+}, nominative: %r{[a-z]+}i, oblique: %r{[a-z]+}i }, as: :user
  
  root to: 'home#index'
end
