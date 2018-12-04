class NewImageSendEmails < ApplicationJob
  def perform(image_id)
    image = Image.find(image_id)
    image.category.follows.each do |follow|
      UserMailer.with(user: follow.user, category: image.category.name).new_image_email.deliver
    end
  end
end