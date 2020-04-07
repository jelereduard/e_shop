Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'registrations'
  }
  #get 'shop/index'
  root 'shop#index'

  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'
  get 'static_pages/contact'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
