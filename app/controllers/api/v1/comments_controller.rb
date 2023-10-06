class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_post, only: [:create]

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    render json: @comments
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user
    if @comment.save
      render json: @comment
    else
      render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = current_user.posts.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
