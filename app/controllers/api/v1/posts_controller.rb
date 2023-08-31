class Api::V1::PostsController < ApplicationController
    load_and_authorize_resource
    rescue_from CanCan::AccessDenied do |_exception|
      redirect_to root_path, notice: 'Access denied'
    end
    def index
      @user = User.includes(:posts).find(params[:user_id])
      @posts = Post.where(author: @user)
      render json: @posts, status: :ok
    end
  end