class SessionsController < Devise::SessionsController
  def create
    fails = User.find_by(email: sign_in_params[:email])&.failed_attempts

    super && return unless fails

    if fails > User.logins_before_captcha
      if recaptcha_present?(params) && !verify_recaptcha
        sign_out # !!!!!!!!!!!!!!
        self.resource = resource_class.new(sign_in_params)
        render :new
        return
      end
    end

    record_activity('log in')
    super
  end

  def destroy
    record_activity('log out')
    super
  end

  private

  def recaptcha_present?(params)
    params['g-recaptcha-response']
  end

  def decrement_failed_attempts(user)
    user.update!(failed_attempts: user.failed_attempts - 1)
  end
end
