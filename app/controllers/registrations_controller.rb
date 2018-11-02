class RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: %i[create]

  private

  def check_captcha
    unless verify_recaptcha
      self.resource = resource_class.new sign_up_params
      resource.validate # Look for any other validation errors besides Recaptcha
      set_minimum_password_length
      respond_with resource
    end
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def account_update_params
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  end
end