class ImagesController < ApplicationController
  before_action :get_image, only: %i[show, edit, update, destroy]

  @@current_category = nil

  def index
    @images = Image.all
    # @category_id = Category.find(params[:category_id])
  end

  def show_category
    @@current_category = params[:id]
    @images = Image.where("category_id = #{current_category}")
    render 'index'
  end

  def show
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_param)
    @image.user_id = current_user.id
    @image.category_id = current_category
    if @image.save
      redirect_to show_category_image_path(current_category)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @image.update_attributes(image_param)
      redirect_to show_category_image_path(current_category)
    else
      render 'edit'
    end
  end

  def destroy
    @image.destroy
  end

  private

  def image_param
    params.require(:image).permit(:path, :category_id)
  end

  def get_image
    @image = Image.find(params[:id])
  end

  def current_category
    @@current_category
  end
end
