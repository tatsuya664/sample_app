Rails.application.routes.draw do
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get    "/signup",  to: "users#new"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  resources :users do #14章で追加
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: [:edit] #11章で追加
  resources :password_resets,     only: [:new, :create, :edit, :update] #12章で追加
  resources :microposts,          only: [:create, :destroy] #13章で追加
  resources :relationships,       only: [:create, :destroy] #14章で追加
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
