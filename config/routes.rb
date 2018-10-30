Rails.application.routes.draw do
  namespace :users do
    get 'omniauth_callbacks/facebook'
  end
  # scope '(:locale)' do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, controllers: { sessions: 'sessions', omniauth_callbacks: 'users/omniauth_callbacks' }

  ActiveAdmin.routes(self)

  resources :categories do
    put :follow, on: :member
    put :unfollow, on: :member

    resources :images, only: %i[show new create] do
      put :up_vote, on: :member
      put :down_vote, on: :member

      resources :comments, only: %i[create]
    end
  end

  get 'images', to: 'images#index'
  get 'comments', to: 'comments#index'

  root 'home#index'

  # end
end
