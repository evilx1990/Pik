class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_category, only: %i[show update destroy follow unfollow]

  def index
    @categories = Category.all
    @category = Category.new
    record_activity('navigation')
  end

  def show
    @images = @category.images.page(params[:page])
  end

  def create
    @category = Category.new(category_param)
    @category.user_id = current_user.id

    redirect_to categories_path if @category.save
  end

  def update
    redirect_to categories_path if @category.update(category_param)

    render :edit
  end

  def destroy
    @category.destroy

    redirect_to categories_path
  end

  def follow
    current_user.follow(@category)

    redirect_to categories_path
  end

  def unfollow
    current_user.stop_following(@category)

    redirect_to categories_path
  end

  private

  def category_param
    params.require(:category).permit(:name)
  end

  def get_category
    @category = Category.find(params[:id])
  end
end
