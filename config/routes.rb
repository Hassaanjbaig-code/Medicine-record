Rails.application.routes.draw do
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
