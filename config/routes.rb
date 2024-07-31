Rails.application.routes.draw do
  # post "/push" => "pushnotification#create"
  # get 'pushnotification/create'
  post "/subscribe" => "push_subscribes#create"
  get "/subscribe" => "push_subscribes#index"
  get "/push", to: "push_subscribes#subscribe"

  resources :medicine do
    collection do
      get :complete
    end
  end

   get 'medicines/complete', to: 'medicines#complete', as: 'complete_medicines'
  # resources :push_subscribes

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # devise_scope :user do
  #   # Defines the root path route ("/")
  #   root to: "devise/sessions#new"
  # end

  resources :medicines do
    resources :time_to_eats
    resources :start_end_medicines
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "medicines#index"
end
