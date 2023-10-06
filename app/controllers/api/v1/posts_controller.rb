class Api::V1::PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
      .paginate(page: params[:page], per_page: 5)
    render json: @posts
  end
end
