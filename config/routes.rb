Rails.application.routes.draw do
  get 'dashboards/profile'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # DASHBOARD
  get '/profile', to: "dashboards#profile"

  # BIKES
  resources :bikes do
    resources :chains do
      # resources :tutoriel, only: %I[show]
      get '/tutoriel', to: 'chains#tutoriel', as: 'tutoriel'
    end
    resources :wheels
    resources :brakes
    member do
      get :results
    end
  end
  resources :shops do
    resources :appointments, only: %i[create]
  end
  resources :appointments, only: %i[show index update destroy]
end
