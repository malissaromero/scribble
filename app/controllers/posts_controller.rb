class PostsController < ApplicationController
  skip_before_action :authenticate, only: [:index, :show]

  def index
    @posts = Post.all
    @comment = Comment.new
    #@posts = User.find(session[:user]["id"]).posts
  end

  def show
    @post = Post.find(params[:id])
    @comments = Comment.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create!(post_params.merge({user_id: session[:user]["id"]}))
    redirect_to post_path(@post)

    #@post = Post.create(params[@post])
    #@post.user = current_user
    #@post.save
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
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
