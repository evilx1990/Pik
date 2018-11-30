class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_category, only: %i[show update destroy follow unfollow]

  def index
    @categories = Category.order(name: :desc)
    @category = Category.new
    record_activity('navigation')
  end

  def show
    @images = @category.images.order(id: :asc).page(params[:page])
  end

  def create
    @category = Category.new(category_param)
    @category.user_id = current_user.id

    if @category.save
      redirect_to categories_path
    else
      @category = Category.new
      render :index
    end
  end

  def update
    redirect_to category_path(@category) if @category.update(category_param)
  end

  def destroy
    redirect_to categories_path if @category.destroy
  end

  def follow
    if current_user.follow(@category)
      send_email_after_follow
      redirect_to categories_path
    end
  end

  def unfollow
    if current_user.stop_following(@category)
      redirect_to categories_path
    end
  end

  private

  def category_param
    params.require(:category).permit(:name, :image_id)
  end

  def find_category
    @category = Category.friendly.find(params[:id])
  end

  def send_email_after_follow
    FollowSendEmail.perform_later([current_user.id, params[:id]])
  end
end
