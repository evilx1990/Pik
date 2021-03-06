# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_for_facebook_oath(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect(@user, event: :authentication)
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    else
      redirect_to new_user_registration_url
    end
  end
end