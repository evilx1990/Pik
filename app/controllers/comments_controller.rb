class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @comments = Comment.all
  end

  def create
    @image = Image.find(params[:image_id])
    @comment = @image.comments.new(comment_params)
    @comment.update(image_id: params[:image_id], user_id: current_user.id)
    record_activity('comment')
    increment_scope_category(params[:category_id])

    redirect_to category_image_path(id: @image.id), remote: true
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end