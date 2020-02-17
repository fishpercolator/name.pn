Rails.application.routes.draw do
  get 'offline', to: 'home#offline'
  get 'manifest', to: 'home#manifest'
  root to: 'home#index'
  ActiveAdmin.routes(self)
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
