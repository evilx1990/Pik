Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, controllers: { sessions: 'sessions' }
  ActiveAdmin.routes(self)

  resources :categories

  resources :images do
    get :show_category, on: :member
    put :up_vote, on: :member
    put :down_vote, on: :member

    resources :comments, only: %i[create destroy]
  end

  root 'home#index'
end
