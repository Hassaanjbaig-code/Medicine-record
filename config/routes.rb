Rails.application.routes.draw do
  # get 'specializations/new'
  # get 'clinics/new'
  get 'home/index'
  # post "/push" => "pushnotification#create"
  # get 'pushnotification/create'
  post "/subscribe" => "push_subscribes#create"
  get "/subscribe" => "push_subscribes#index"
  get "/push", to: "push_subscribes#subscribe"

  # resources :push_subscribes

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :doctor_registers, only: [:index, :create, :new] do
    resources :qualifications, only: [:new, :create]
    resources :specializations, only: [:new, :create]
    resources :clinics, only: [:new, :create]
  end

  # devise_scope :user do
  #   # Defines the root path route ("/")
  #   root to: "devise/sessions#new"
  # end

  resources :medicines do
    collection do
      get :complete
    end
    resources :time_to_eats
    resources :start_end_medicines
  end
  resources :doctors do
    namespace :api do
      namespace :v1 do
        resources :appointments, only: [:create, :new, :destroy]
      end
    end
  end

  # get 'complete', to: 'medicines#complete', as: 'complete_medicines'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "medicines#index"
end
