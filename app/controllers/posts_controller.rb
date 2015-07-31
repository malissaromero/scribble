class PostsController < ApplicationController
  skip_before_action :authenticate, only: [:index]

  def index
    @posts = Post.all
    @comment = Comment.new
  end

  def show
    @post = Post.find(params[:id])
    @comments = Comment.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    @post.user_id = current_user["id"]
    redirect_to post_path(@post)
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user_id != current_user["id"]
       redirect_to post_path(@post)
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.user_id = current_user["id"]
    redirect_to posts_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :author, :content)
  end
end
