class TagsController < ApplicationController
  
  def create
    @tag = Tag.new(tag_params)
    unless @tag.save
      flash.now[:errors] = @tag.errors.full_messages
    end
    redirect_to post_url(@tag.post)
  end
  
  # def show
  #   @tag = Tag.find(params[:id])
  #   @posts = @tag.posts
  #   render :show
  # end
  
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to posts_url(@tag.post)
  end
  
  def tag_params
    params.require(:tag).permit(:name, :post_id)
  end
  
end
