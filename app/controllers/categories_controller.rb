class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_category, only: %i[show update destroy follow unfollow]
  before_action :block_id, only: %i[follow unfollow]
  after_action  only: %i[index show] do
    record_activity('navigation')
  end

  def index
    @categories = Category.order(created_at: :desc).page(params[:page])
    @category = Category.new
  end

  def show
    @images = @category.images.order(created_at: :desc).page(params[:page])
  end

  def create
    @category = Category.new(category_param)
    @category.user = current_user

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
    send_email_after_follow(@category.name) if current_user.follow(@category)
  end

  def unfollow
    current_user.stop_following(@category)
  end

  private

  def category_param
    params.require(:category).permit(:name, :preview)
  end

  def find_category
    @category = Category.friendly.find(params[:id])
  end

  def block_id
    @block = "#category_#{params[:block_id]}"
  end

  def send_email_after_follow(category_name)
    url = "#{request.protocol + request.host}/#{params[:locale]}/categories/#{params[:id]}"
    FollowSendEmailJob.perform_later(current_user.id, category_name, url)
  end
end
