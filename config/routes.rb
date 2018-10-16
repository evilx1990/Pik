Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, controllers: { sessions: 'sessions' }
  ActiveAdmin.routes(self)

  resources :categories do
    put :follow, on: :member
    put :unfollow, on: :member
  end

  resources :images, only: %i[index show create] do
    get :show_category, on: :member
    put :up_vote, on: :member
    put :down_vote, on: :member
  end

  resources :comments, only: %i[index create]

  root 'home#index'
end
