Rails.application.routes.draw do
  get 'about_pages/show'
  get 'categories/index'
  get 'categories/show'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :categories, only: [:index, :show]
  resources :about_pages, only: [:show]
end
