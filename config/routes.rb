Rails.application.routes.draw do
  get 'offline', to: 'home#offline'
  get 'manifest', to: 'home#manifest'
  
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  ActiveAdmin.routes(self)  
  
  devise_for :users, controllers: { 
    registrations: 'registrations' 
  }
  devise_for :clients, skip: :all
  
  get 'users/mailing_list', to: 'mailing_list#show'
  post 'users/mailing_list/subscribe', to: 'mailing_list#subscribe'
  post 'users/mailing_list/unsubscribe', to: 'mailing_list#unsubscribe'
  
  resources :profile
  resources :clients, only: %i[create destroy]
  
  get "/:id(/:nominative/:oblique)", to: 'users#show', constraints: { id: %r{[-a-z\d]+}i, nominative: %r{[a-z]+}i, oblique: %r{[a-z]+}i }, as: :user
  
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :users, only: [:show]
    end
  end  
  
  root to: 'home#index'
end
