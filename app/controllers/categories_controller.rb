class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_category, only: %i[edit update destroy follow unfollow]

  def index
    @category = Category.new
    @categories = Category.all
    record_activity('navigation')
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_param)

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
    @user = current_user
    @user.follow(@category)

    redirect_to categories_path
  end

  def unfollow
    @user = current_user
    @user.stop_following(@category)

    redirect_to categories_path
  end

  private

  def category_param
    params.require(:category).permit(:name, :user_id)
  end

  def get_category
    @category = Category.find(params[:id])
  end
end
