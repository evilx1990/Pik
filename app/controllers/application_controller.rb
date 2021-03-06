# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: %i[username password password_confirmation remember_me]
    devise_parameter_sanitizer.permit :sign_in, keys: %i[username password remember_me]
    devise_parameter_sanitizer.permit :account_update, keys: %i[username email password password_confirmation
                                                              avatar avatar_cache remove_avatar]
  end

  def record_activity(note)
    Activity.create!(user: current_user, action: note, url: request.original_url)
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
