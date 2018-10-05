class CategoriesController < ApplicationController
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
    if @category.save
      redirect_to
    end
  end

  private

  def category_param
    params.require(:category).permit(:name, :username)
  end
end
