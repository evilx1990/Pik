class ImagesController < ApplicationController
  before_action :image, only: %i[show edit update destroy]

  def show_category
    @images = Image.where("category_id = #{params[:id]}")
  end

  def show; end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new(image_param)

    if @image.save
      increment_cat_images
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
    decrement_cat_images
    @image.destroy

    redirect_to show_category_image_path(id)
  end

  private

  def image_param
    params.require(:image).permit(:path, :user_id, :category_id)
  end

  def image
    @image = Image.find(params[:id])
  end

  def category_id
    @image.category_id
  end

  def increment_cat_images
    note = Category.find(@image.category_id)
    note.increment!(:count)
  end

  def decrement_cat_images
    note = Category.find(@image.category_id)
    note.decrement!(:count)
  end
end
