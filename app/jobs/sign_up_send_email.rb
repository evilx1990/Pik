class SignUpSendEmail < ApplicationJob
  def perform(user_id)
    user = User.find(user_id)
    UserMailer.with(user: user).welcome_email.deliver
  end
end