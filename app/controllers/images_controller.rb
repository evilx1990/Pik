class ImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_image, only: %i[show edit update destroy up_vote down_vote]

  def show_category
    @images = Image.where('category_id = ?', params[:id])
  end

  def show; end

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

  def edit; end

  def update
    if @image.update(image_param)
      redirect_to show_category_image_path(category_id)
    else
      render :edit
    end
  end

  def destroy
    id = category_id
    decrement_category_img
    @image.destroy

    redirect_to show_category_image_path(id)
  end

  def up_vote
    @image.liked_by current_user
    redirect_to image_path(@image)
  end

  def down_vote
    @image.downvote_from current_user
    redirect_to image_path(@image)
  end

  private

  def image_param
    params.require(:image).permit(:path, :user_id, :category_id)
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
