Rails.application.routes.draw do
  get 'products/index'
  get 'products/show'
  get '/contactus' => 'contact_pages#show', as: '/contactus'
  get '/aboutus' => 'about_pages#show', as: '/aboutus'
  get 'categories/index'
  get 'categories/show'
  root to: 'home#index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :categories, only: [:index, :show]
  resources :products, only: [:index, :show] do
    collection do
      get 'search'
      get 'filter'
    end
  end
end
