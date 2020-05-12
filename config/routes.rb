Rails.application.routes.draw do
  get '/orders/subregion_options', to: 'orders#subregion_options'

  resources :orders
  resources :carts
  devise_for :users, controllers: {
    registrations: 'registrations'
  }
  root 'shop#index'

  get  '/home',    to: 'products#index'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/dashboard',to:'dashboards#dashboard'

  resources :categories
  resources :products
  resources :order_items do 
    member do
      get :decrement_quantity
      get :increment_quantity
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
