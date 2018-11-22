class SessionsController < Devise::SessionsController
  def create
    super
    record_activity('log in')
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
