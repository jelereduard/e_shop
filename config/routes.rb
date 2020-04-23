Rails.application.routes.draw do

  resources :orders
  resources :carts
  devise_for :users, controllers: {
    registrations: 'registrations'
  }
  # get 'shop/index'
  root 'shop#index'

  get  '/home',    to: 'products#index'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/dashboard',to:'dashboards#dashboard'

  resources :categories
  resources :products
  resources :order_items

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
