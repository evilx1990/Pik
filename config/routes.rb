Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, controllers: { sessions: 'sessions' }
  ActiveAdmin.routes(self)

  resources :categories do
    put :follow, on: :member
    put :unfollow, on: :member

    resources :images, only: %i[index show new create] do
      put :up_vote, on: :member
      put :down_vote, on: :member

      resources :comments, only: %i[create]
    end
  end

  root 'home#index'
end
