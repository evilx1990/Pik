class RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: %i[create]

  def create
    super
    SignUpSendEmailJob.perform_later(@user.id, "#{request.protocol + request.host}") unless @user.errors.any?
  end

  def update
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)
    @user = current_user

    if needs_password?
      successfully_updated = @user.update_with_password(account_update_params)
    else
      account_update_params.delete('password')
      account_update_params.delete('password_confirmation')
      account_update_params.delete('current_password')
      successfully_updated = @user.update_attributes(account_update_params)
    end

    if successfully_updated
      set_flash_message :notice, :updated
      sign_in @user, bypass: true
      redirect_to edit_user_registration_path
    else
      render :edit
    end
  end

  private

  def needs_password?
    @user.email != params[:user][:email] || params[:user][:password].present?
  end

  def check_captcha
    return if verify_recaptcha

    self.resource = resource_class.new sign_up_params
    resource.validate
    set_minimum_password_length
    respond_with resource
  end
end