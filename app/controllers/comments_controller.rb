# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @comments = Comment.order(created_at: :desc)
  end

  def create
    @comment = Image.friendly.find(params[:image_id]).comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      record_activity('comment')
      redirect_to category_image_path(category_id: @comment.image.category.slug,
                                      id: @comment.image.slug )
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
