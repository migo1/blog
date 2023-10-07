class Api::V1::PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
      .paginate(page: params[:page], per_page: 5)
    render json: @posts
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      render :show, status: :created, location: @api_v1_post
    else
      render json: @api_v1_post.errors, status: :unprocessable_entity
    end
  end
end
