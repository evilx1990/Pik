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
    if current_user
      @activity = Activity.new(user_id: current_user.id,
                               action: note,
                               url: request.original_url).save
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def after_sign_in_path_for(resource)
    resource.encrypted_password.present? ? categories_path : edit_user_registration_path
  end
end
