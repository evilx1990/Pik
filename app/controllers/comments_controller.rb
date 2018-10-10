class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_image, only: %i[create destroy]

  def create
    @comment = @image.comments.create(comment_params)
    redirect_to image_path(@image)
  end

  def destroy
    @comment = @image.comments.destroy
  end

  private

  def find_image
    @image = Image.find(params[:image_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :image_id, :user_id)
  end
end
