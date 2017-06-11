Rails.application.routes.draw do

  resources :wikis
  get '/wikis/new/:id', to: 'wikis#new', as: 'new_wiki_project_id'
  post '/wikis/new/:id', to: 'wikis#create', as: 'create_wiki_project_id'
  
  # the difference between :wikis and :resources here is
  # that documents have two separate forms for new and update...
  patch '/wikis/new/:id', to: 'wikis#update', as: 'update_wiki_project_id'
  
  resources :documents 
  get '/documents/new/:id', to: 'documents#new', as: 'new_document_project_id'
  post '/documents/new/:id', to: 'documents#create', 
    as: 'create_document_project_id'
    
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
