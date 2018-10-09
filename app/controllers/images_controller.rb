class ImagesController < ApplicationController
  before_action :get_image, only: %i[show edit update destroy]

  def show_category
    @images = Image.where("category_id = #{params[:id]}")
  end

  def show
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_param)

    if @image.save
      redirect_to show_category_image_path(@image.category_id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @image.update(image_param)
      redirect_to show_category_image_path(current_category)
    else
      render :edit
    end
  end

  def destroy
    @image.destroy

    redirect_to show_category_image(params[:id])
  end

  private

  def image_param
    params.require(:image).permit(:path, :user_id, :category_id)
  end

  def get_image
    @image = Image.find(params[:id])
  end
end
