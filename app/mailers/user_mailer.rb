# frozen_string_literal: true

class UserMailer < ApplicationMailer
  before_action do
    @user = User.find(params[:user_id])
    @url = params[:url]
  end

  def welcome_email
    mail(to: @user.email, subject: 'Welcome Gallery') if @user.email.present?
  end

  def follow_email
    mail(to: @user.email, subject: 'Follow') if @user.email.present?
  end

  def new_image_email
    mail(to: @user.email, subject: 'New image') if @user.email.present?
  end

  def share_image_email
    mail(to: params[:email], subject: 'Hello! Take it look')
  end
end
