Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root "home#index"

  resources :rooms, only: [ :index, :show, :new, :create ] do
    get :own, on: :collection
end

  resources :reservations, only: [ :index, :create ] do
    collection do
      post :confirm
    end
  end

  namespace :users do
    resource :profile, only: [ :show, :edit, :update ], controller: "profile"
    resource :account, only: :show, controller: "account"
  end
end
