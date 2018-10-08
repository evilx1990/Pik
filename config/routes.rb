Rails.application.routes.draw do
  get 'home/index'
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :categories

  resources :images do
    get :show_category, on: :member
    resources :comments
  end

  root 'home#index'
end
