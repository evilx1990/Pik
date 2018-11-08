class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_category, only: %i[show update destroy follow unfollow]

  def index
    @categories = Category.order(count: :desc)
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
      render :index
    end
  end

  def update
    @category.update(category_param)
    redirect_to category_path(@category)
  end

  def destroy
    @category.destroy
    redirect_to categories_path
  end

  def follow
    current_user.follow(@category)
    UserMailer.with(user: current_user,
                    category: params[:id]).follow_email.deliver_later
    redirect_to categories_path
  end

  def unfollow
    current_user.stop_following(@category)
    redirect_to categories_path
  end

  private

  def category_param
    params.require(:category).permit(:name, :image_id)
  end

  def find_category
    @category = Category.friendly.find(params[:id])
  end
end
