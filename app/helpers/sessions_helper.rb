module SessionsHelper
  def show_recaptcha
    session[:login_failure] ? session[:login_failure] += 1 : session[:login_failure] = 0
    return '' unless session[:login_failure] > User.logins_before_captcha

    recaptcha_tags
  end
end
