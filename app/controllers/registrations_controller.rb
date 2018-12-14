class RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: %i[create]

  def create
    super
    SignUpSendEmailJob.perform_later(@user.id) unless @user.errors.any?
  end

  private

  def after_update_path_for(resource)
    edit_user_registration_path
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def check_captcha
    return if verify_recaptcha

    self.resource = resource_class.new sign_up_params
    resource.validate
    set_minimum_password_length
    respond_with resource
  end
end