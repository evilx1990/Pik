class ImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_image, only: %i[show up_vote down_vote download share]
  before_action :find_category, only: %i[new create]

  def index
    @images = Image.order(votes_count: :desc).page(params[:page]).per(20)
  end

  def show
    @comments = @image.comments.order(created_at: :desc).page(params[:page]).per(10)
    record_activity('navigation')
  end

  def new
    @image = @category.images.new
  end

  def create
    @image = @category.images.new(image_param)
    @image.user_id = current_user.id

    if @image.save
      NewImageSendEmails.perform_later(@image.id)
      redirect_to category_path(params[:category_id])
    end
  end

  def download
    send_file(@image.picture.path)
  end

  def share
    UserMailer.with(email: params[:share][:email],
                    url: params[:share][:url],
                    message: params[:share][:message]).share_image.deliver_later
    redirect_to category_image_path(category_id: @image.category.slug, id: @image.slug)
  end

  def up_vote
    record_activity('like') if @image.vote_from(current_user.id, true)
    redirect_to category_image_path(category_id: @image.category.slug, id: @image.slug)
  end

  def down_vote
    record_activity('dislike') if @image.vote_from(current_user.id, false)
    redirect_to category_image_path(category_id: @image.category.slug, id: @image.slug)
  end

  private

  def image_param
    params.require(:image).permit(:picture, :image_name)
  end

  def find_category
    @category = Category.friendly.find(params[:category_id])
  end

  def find_image
    @image = Image.friendly.find(params[:id])
  end
end
