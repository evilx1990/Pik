# frozen_string_literal: true

class FollowSendEmailJob < ApplicationJob
  queue_as :mailer

  def perform(user_id, category_id, url)
    UserMailer.with(user_id: user_id, category_id: category_id, url: url).follow_email.deliver
  end
end
