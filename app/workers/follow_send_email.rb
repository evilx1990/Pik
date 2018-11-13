class FollowSendEmail
  @queue = :mailer

  def self.perform(arr)
    user = User.find(arr[0])
    UserMailer.with(user: user, category: arr[1]).follow_email.deliver_later
  end
end