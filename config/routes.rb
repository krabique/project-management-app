Rails.application.routes.draw do

  #get 'documents/edit'
  #resources :documents, only: [:edit]
  #get '/projects/:id/documents/edit/:project_id', to: 'documents#edit'
  
  resources :documents 
  resources :projects
  
  

  get 'tags/:tag', to: 'projects#index', as: :tag

  #resources :documents, only: [:edit]
  
  

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
