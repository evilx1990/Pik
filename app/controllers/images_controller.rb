class ImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_image, only: %i[show edit update destroy up_vote down_vote]
  before_action :find_category, only: %i[index new]

  def index
    record_activity('navigation')
  end

  def show
    record_activity('navigation')
  end

  def new; end

  def create
    @image = Image.new(image_param)
    @image.update(category_id: params[:category_id], user_id: current_user.id)

    redirect_to category_path(params[:category_id])
  end

  def up_vote
    if current_user.liked? @image
      @image.unliked_by(current_user)
    else
      @image.upvote_from(current_user)
    end
    record_activity('like')
    redirect_to category_image_path(@image)
  end

  def down_vote
    if current_user.disliked? @image
      @image.undisliked_by(current_user)
    else
      @image.downvote_from(current_user)
    end
    record_activity('dislike')
    redirect_to category_image_path(@image)
  end

  private

  def image_param
    params.require(:image).permit(:picture, :image_name)
  end

  def find_image
    @image = Image.find(params[:id])
  end

  def find_category
    @category = Category.find(params[:category_id])
  end

  def category_id
    @image.category_id
  end
end
