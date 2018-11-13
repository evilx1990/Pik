class SignUpSendEmail
  @queue = :mailer

  def self.perform(user_id)
    user = User.find(user_id)
    UserMailer.with(user: user).welcome_email.deliver_later
  end
end