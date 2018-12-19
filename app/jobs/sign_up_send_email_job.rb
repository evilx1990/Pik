class SignUpSendEmailJob < ApplicationJob
  queue_as :mailer

  def perform(user_id, url)
    UserMailer.with(user_id: user_id, url: url).welcome_email.deliver
  end
end