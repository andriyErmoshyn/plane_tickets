Rails.application.routes.draw do

  root 'destinations#index'

  resources :destinations
  resources :users, only: [ :new, :create, :show, :edit, :update ]
  resources :password_resets, only: [ :new, :create, :edit, :update ]

  get 'signup'    => 'users#new'
  get 'login'       => 'sessions#new'
  post 'login'      => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

end