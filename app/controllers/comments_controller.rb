class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @image = Image.find(params[:image_id])
    @comment = @image.comments.create(comment_params)
    record_activity('comment')
    redirect_to image_path(@image)
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :image_id, :user_id)
  end
end