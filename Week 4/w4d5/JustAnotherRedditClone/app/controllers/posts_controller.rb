class PostsController < ApplicationController
  before_action :ensure_author, only: [:update, :edit]

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @sub = Sub.find(params[:sub_id])
    @post.sub_id = @sub.id
    if @post.save
      redirect_to @sub
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @sub = @post.sub
    render :show
  end
  
  
  def edit
    @post = Post.find(params[:id])
    @sub = Sub.find(params[:sub_id])
    render :edit
  end
  
  def new
    @sub = Sub.find(params[:sub_id])
    @post = Post.new
    render :new
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :content)
  end
  
  def ensure_author
    unless Post.find(params[:id]).author_id == current_user.id
      flash[:errors] = ["You cannot edit random cat posts you did not create"]
      redirect_to Sub.find(params[:sub_id])
    end
  end
  
end
