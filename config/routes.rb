Rails.application.routes.draw do

  resources :projects
  

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      passwords: 'users/passwords',
      registrations: 'users/registrations'
  }
  
  resources :users, only: [:show]
  # For details on the DSL available within this file, 
  # see http://guides.rubyonrails.org/routing.html
  
  root to: 'home#index'
end
