# frozen_string_literal: true

require 'resque/server'

Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, only: :omniauth_callbacks, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  scope '(:locale)' do
    devise_for :users, skip: :omniauth_callbacks, controllers: {
      sessions: 'sessions',
      registrations: 'registrations'
    }

    resources :categories, only: %i[index show create update destroy] do
      put :follow, on: :member
      put :unfollow, on: :member

      resources :images, only: %i[show new create] do
        put :like, on: :member
        put :dislike, on: :member
        get :download, on: :member
        get :share, on: :member

        resources :comments, only: %i[create]
      end
    end

    get 'images', to: 'images#index'
    get 'comments', to: 'comments#index'

    root 'home#index'
  end
end
