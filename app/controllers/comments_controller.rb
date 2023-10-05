class CommentsController < ApplicationController
  before_action :set_user
  before_action :set_post
  before_action :set_comment, only: %i[destroy]

  def new
    @comment = @post.comments.new
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.author = @user
    if @comment.save
      flash[:notice] = 'Comment created successfully.'
      redirect_to user_post_path(@user, @post)
    else
      render 'new'
    end
  end

  def destroy
    if @comment.destroy
      flash[:notice] = 'Comment was successfully deleted.'
    else
      flash[:alert] = 'Failed to delete comment.'
    end

    redirect_to user_post_path(@user, @post)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
