Rails.application.routes.draw do
  get 'cart', to: 'cart#show'
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
 end
  get 'products/index'
  get 'products/show' => 'products#show', as: 'product/show'
  get '/contactus' => 'contact_pages#show', as: '/contactus'
  get '/aboutus' => 'about_pages#show', as: '/aboutus'
  get 'categories/index'
  get 'categories/show'
  get "checkout/create", to: "checkout#create"
  get "checkout/success", to: "checkout#success"
  get "checkout/cancel", to: "checkout#cancel"
  post 'cart/add'
  post 'cart/remove'
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
