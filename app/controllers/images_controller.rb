# frozen_string_literal: true

class ImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_image, only: %i[show download share like dislike]
  before_action :find_category, only: %i[new create]

  def index
    @images = Image.order(created_at: :desc).page(params[:page])
  end

  def show
    @comment = @image.comments.new
    @comments = @image.comments.order(created_at: :desc).page(params[:page]).per(6)
    record_activity('navigation')
  end

  def new
    @image = @category.images.new
  end

  def create
    @image = @category.images.new(image_param)
    @image.user = current_user

    if @image.save!
      send_new_image_emails(@image)
      redirect_to category_path(params[:category_id])
    end
  end

  def download
    if %w[development test].include?(ENV['RAILS_ENV'])
      send_file(@image.picture.path)
    else
      send_data(open(@image.picture.url).read, filename: File.basename(@image.picture.path))
    end
  end

  def share
    UserMailer.with(share_param).share_image_email.deliver_later
    redirect_to category_image_path(category_id: @image.category.slug, id: @image.slug)
  end

  def like
    @image.vote_from(current_user, true)
    record_activity('like')
    render 'images/votes'
  end

  def dislike
    @image.vote_from(current_user, false)
    record_activity('dislike')
    render 'images/votes'
  end

  private

  def image_param
    params.require(:image).permit(:picture, :name)
  end

  def share_param
    email_data = params.require(:share).permit(:email, :url, :message)
    email_data[:user_id] = current_user.id
    email_data
  end

  def find_category
    @category = Category.friendly.find(params[:category_id])
  end

  def find_image
    @image = Image.friendly.find(params[:id])
  end

  def send_new_image_emails(image)
    url_category = "#{request.protocol + request.host}/#{params[:locale]}/categories/#{params[:category_id]}"
    url_image = url_category + "/images/#{image.slug}"
    image = Image.friendly.find(image.slug)

    image.category.follows.each do |follow|
      NewImageSendEmailsJob.perform_later(url_category, url_image, follow.user.id, image.category.name)
    end
  end
end
