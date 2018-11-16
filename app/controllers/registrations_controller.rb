class RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: %i[create]

  def create
    super
    # Resque.enqueue(SignUpSendEmail, @user.id) unless @user.errors.any?
    SignUpSendEmail.perform_later(@user.id) unless @user.errors.any?
  end

  private

  # def update_resource(resource, params)
  #   unless params[:password].blank?
  #     resource.password = params[:password]
  #     resource.password_confirmation = params[:password_confirmation]
  #   end
  #
  #   resource.update_without_password(params)
  # end

  def check_captcha
    return if verify_recaptcha

    self.resource = resource_class.new sign_up_params
    resource.validate
    set_minimum_password_length
    respond_with resource
  end
end