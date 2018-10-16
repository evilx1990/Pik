class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @comments = Comment.all
  end

  def create
    @comment = Comment.create(comment_params)
    record_activity('comment')
    redirect_to image_path(params[:comment].fetch(:image_id))
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :image_id, :user_id)
  end
end
