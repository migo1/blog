class PostsController < ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource :post, through: :user
  before_action :set_user
  before_action :set_post, only: %i[show destroy]

  def index
    @posts = Post.includes(:comments)
      .where(author: params[:user_id])
      .paginate(page: params[:page], per_page: 5)
    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @post }
    end
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to user_path(@user), notice: 'Post was successfully created.'
    else
      puts @post.errors.full_messages
      render :new
    end
  end

  def like
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])

    @like = @post.likes.new
    @like.author = current_user

    if @like.save
      flash[:notice] = 'Post liked successfully.'
    else
      flash[:alert] = 'Failed to like the post.'
    end

    redirect_to user_post_path(@user, @post)
  end

  def destroy
    @author = @post.author
    @post.likes.destroy_all
    @post.comments.destroy_all
    @author.decrement!(:posts_counter)
    if @post.destroy
      flash[:notice] = 'Post was successfully deleted.'
    else
      flash[:alert] = 'Failed to delete Post.'
    end

    redirect_to user_posts_path(@user)
  end

  def post_params
    params.require(:post).permit(:title, :text, :comments_counter, :likes_counter)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
