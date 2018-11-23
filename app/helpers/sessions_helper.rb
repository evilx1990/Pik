module SessionsHelper
  def show_recaptcha
    return '' unless session[:login_failure]
    return '' if session[:login_failure] <= User.logins_before_captcha

    recaptcha_tags
  end
end
