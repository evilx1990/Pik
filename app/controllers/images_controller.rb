class ImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_image, only: %i[show edit update destroy up_vote down_vote]

  def index
    @images = Image.all.page(params[:page]).per(20)
  end

  def show_category
    @images = Image.where('category_id = ?', params[:id])
    @images = @images.page(params[:page])
    record_activity('navigation')
  end

  def show
    @comments = Comment.where('image_id = ?', params[:id])
    record_activity('navigation')
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_param)

    if @image.save
      increment_category_img
      redirect_to show_category_image_path(category_id)
    else
      render :new
    end
  end

  def up_vote
    if current_user.liked? @image
      @image.unliked_by(current_user)
    else
      @image.upvote_from(current_user)
    end
    record_activity('like')
    redirect_to image_path(@image)
  end

  def down_vote
    if current_user.disliked? @image
      @image.undisliked_by(current_user)
    else
      @image.downvote_from(current_user)
    end
    record_activity('dislike')
    redirect_to image_path(@image)
  end

  private

  def image_param
    params.require(:image).permit(:picture, :user_id, :category_id)
  end

  def find_image
    @image = Image.find(params[:id])
  end

  def increment_category_img
    Category.find(@image.category_id).increment!(:count)
  end

  def decrement_category_img
    Category.find(@image.category_id).decrement!(:count)
  end

  def category_id
    @image.category_id
  end
end
