class FollowSendEmail < ApplicationJob
  self.queue_adapter = :resque
  queue_as :mailer

  def perform(arr)
    user = User.find(arr[0])
    UserMailer.with(user: user, category: arr[1]).follow_email.deliver
  end
end