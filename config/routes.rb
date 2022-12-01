Rails.application.routes.draw do
  get 'products/index'
  get 'products/show'
  get '/contactus' => 'contact_pages#show', as: '/contactus'
  get '/aboutus' => 'about_pages#show', as: '/aboutus'
  get 'categories/index'
  get 'categories/show'
  get "checkout/create", to: "checkout#create"
  get "products/add_to_cart/:id", to: "products#add_to_cart", as: "add_to_cart"
  get "products/remove_from_cart/:id", to: "products#remove_from_cart", as: "remove_from_cart"
  root to: 'home#index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :categories, only: [:index, :show]
  resources :products do
    collection do
      get 'search'
      get 'filter'
      get 'recently_updated', to: "products#update"
    end
  end
end
