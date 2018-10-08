class CategoriesController < ApplicationController
  before_action :get_category, only: %i[show edit update destroy]

  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_param)
    @category.user_id = current_user.id
    if @category.save
      redirect_to categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes(category_param)
      redirect_to category_path(@category)
    else 
      render :edit
    end
  end

  def destroy
    @category.destroy
  end

  private

  def category_param
    params.require(:category).permit(:name)
  end

  def get_category
    @category = Category.find(params[:id])
  end
end
