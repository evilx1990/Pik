class ImagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_image, only: %i[show like dislike]
  before_action :find_category, only: %i[new create]

  def index
    @images = Image.all.page(params[:page]).per(20)
  end

  def show
    record_activity('navigation')
  end

  def new
    @image = @category.images.new
  end

  def create
    @image = @category.images.new(image_param)
    @image.user_id = current_user.id

    redirect_to category_path(params[:category_id]) if @image.save
  end

  def like
    record_activity('like') if @image.like_from(current_user)
    redirect_to category_image_path(category_id: @image.category.slug, id: @image.slug)
  end

  def dislike
    record_activity('dislike') if @image.dislike_from(current_user)
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
