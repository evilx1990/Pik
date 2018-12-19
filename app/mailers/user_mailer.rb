class UserMailer < ApplicationMailer
  before_action :user_from_params
  before_action :url_category, only: %i[follow_email new_image_email]

  def welcome_email
    @url = 'http://localhost:3000/users/sign_in'
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

  private

  def user_from_params
    @user = params[:user]
  end

  def url_category
    @url = "#{request.protocol + request.host}/categories/#{params[:category]}"
  end
end
