Rails.application.routes.draw do

  get '/about', to: 'about#index', as: 'about'
  root to: 'products#index'

  resources :products, only: [:index, :show]
  resources :categories, only: [:show]

  resource :cart, only: [:show] do
    post   :add_item
    post   :remove_item
  end

  resources :orders, only: [:create, :show]

  namespace :admin do
    root to: 'dashboard#show'
    resources :products, except: [:edit, :update, :show]
    resources :categories, only: [:index, :new, :create]
    resources :sales, only: [:index, :new]
  end

  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:index, :create]
end

New::Application.routes.draw do

  # sends request to naked url to the *cool* action in the *gif* controller
  # root to: 'gif#cool'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'


end