Rails.application.routes.draw do
  get 'products/new'
  devise_for :users, controllers: {
    registrations: 'registrations'
  }
  # get 'shop/index'
  root 'products#index'

  # get  '/home',    to: 'products#index'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
