Rails.application.routes.draw do
  
  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  
  resources :projects do
    resources :wikis
    resources :documents
    resources :discussions do
      resources :posts
    end
  end
  
  get 'tags/:tag', to: 'projects#index', as: :tag
  get 'tag_list', to: 'tags#index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
      sessions: 'users/sessions',
      passwords: 'users/passwords',
      registrations: 'users/registrations'
  }
  
  resources :users, only: [:show]
  
  root to: 'home#index'
  
  mount ActionCable.server, at: '/cable'
end
