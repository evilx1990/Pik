class SessionsController < Devise::SessionsController
  def create
    session[:login_failure] ? session[:login_failure] += 1 : session[:login_failure] = 0

    if session[:login_failure] > 3
      if recaptcha_present?(params) && !verify_recaptcha
        fails = session[:login_failure]
        sign_out
        session[:login_failure] = fails
        self.resource = resource_class.new
        render 'devise/sessions/new'
        return
      end
    end

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
end
