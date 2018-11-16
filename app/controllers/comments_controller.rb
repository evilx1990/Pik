class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @comments = Comment.order(created_at: :desc).all
  end

  def create
    @comment = Image.find(params[:image_id]).comments.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      record_activity('comment')
      redirect_to category_image_path(id: params[:image_id]), remote: true
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :image_id)
  end
end