class NewImageSendEmailsJob < ApplicationJob
  queue_as :mailer

  def perform(url_category, url_image, user_id, category_id)
    UserMailer.with(user_id: user_id,
                    category_id: category_id,
                    url_category: url_category,
                    url: url_image).new_image_email.deliver
  end
end