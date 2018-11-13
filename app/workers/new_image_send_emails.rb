class NewImageSendEmails
  @queue = :mailer

  def self.perform(image_id)
    image = Image.find(image_id)
    image.category.followers.each do |user|
      UserMailer.with(user: user, category: image.category.name).new_image_email.deliver_later
    end
  end
end