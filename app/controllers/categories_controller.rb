class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_category, only: %i[show edit update destroy follow unfollow]

  def index
    @categories = Category.all
    record_activity('navigation')
  end

  def show
    @images = @category.images.page(params[:page])
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

  def edit; end

  def update
    if @category.update(category_param)
      redirect_to categories_path
    else
      render :edit
    end
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
    params.require(:category).permit(:name, :preview)
  end

  def get_category
    @category = Category.find(params[:id])
  end
end
