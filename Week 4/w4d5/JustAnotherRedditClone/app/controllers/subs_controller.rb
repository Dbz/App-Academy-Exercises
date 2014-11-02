class SubsController < ApplicationController
  before_action :ensure_moderator, only: [:update, :edit]
  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to @sub
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end
  
  def update
    @sub = Sub.find_by(params[:id])
    if @sub.update(sub_params)
      redirect_to @sub
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end
  
  def index
    @subs = Sub.all
    render :index
  end
  
  def show
    @sub = Sub.find(params[:id])
    render :show
  end
  
  def edit
    @sub = Sub.find_by(params[:id])
    render :edit
  end
  
  def new
    @sub = Sub.new
    render :new
  end
  
  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end
  
  def ensure_moderator
    redirect_to subs_url unless Sub.find(params[:id]).moderator_id == current_user.id
  end
  
end
