Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :categories

  resources :images do
    resources :comments
  end

  root 'categories#index'
end
