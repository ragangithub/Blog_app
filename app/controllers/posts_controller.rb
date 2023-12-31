class PostsController < ApplicationController
  load_and_authorize_resource
  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to root_path, notice: 'Access denied'
  end
  def index
    @posts = Post.all
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:author, comments: :author)
    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def show
    @post = Post.includes(:author, comments: :author).find(params[:id])
    @user = @post.author
  end

  def new
    @post = Post.new
    @user = User.find(params[:user_id])
  end

  def create
    @post = Post.new(post_params)
    @user = User.find(params[:user_id])
    @post.author = current_user
    if @post.save
      redirect_to user_post_url(@user, @post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to user_posts_path(@post.author_id)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
