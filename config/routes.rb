Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # DASHBOARD
  get '/profile', to: "dashboards#profile"

  # BIKES
  resources :bikes do
    resources :chains
    resources :wheels
    resources :brakes
    member do
      get :results
    end
  end
end
