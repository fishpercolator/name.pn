Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get "offline", to: "offline#show"
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    registrations: "registrations"
  }
  devise_for :clients, skip: :all

  get "users/mailing_list", to: "mailing_list#show"
  post "users/mailing_list/subscribe", to: "mailing_list#subscribe"
  post "users/mailing_list/unsubscribe", to: "mailing_list#unsubscribe"
  get "/pages/*id" => "pages#show", as: :page, format: false

  resources :profile
  resources :clients, only: %i[create destroy]

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [ :show ]
    end
  end

  get "/:id(/:nominative/:oblique)", to: "users#show", constraints: { id: %r{[-a-z\d]+}i, nominative: %r{[a-z]+}i, oblique: %r{[a-z]+}i, format: %r{html|png} }, as: :user
  root to: "home#index"
end
