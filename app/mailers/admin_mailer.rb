# frozen_string_literal: true

class AdminMailer < ApplicationMailer
  def reply_feedback_email
    mail(to: params[:email], subject: 'Response to your feedback')
  end
end
