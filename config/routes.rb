require 'sidekiq/web'
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :projects
  resources :users
  resources :roles
  resources :messages, only: [:index]
  resources :chatroom, only: [:index]
  # resources :sessions, only: [:new, :create]
  mount ActionCable.server, at: '/cable'
  mount Sidekiq::Web , at: '/sidekiq'
  # root 'projects#index'
  root 'welcome#home'
  get 'welcome/about', to:'welcome#about'
  get 'login', to:'sessions#new'
  post 'login', to:'sessions#create'
  delete 'logout', to:'sessions#destroy'
  get 'logout', to:'sessions#destroy'
  get 'signup', to:'users#new'
  post 'message', to:'messages#create'
end
