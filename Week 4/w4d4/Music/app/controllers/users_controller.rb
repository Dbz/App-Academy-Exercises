class UsersController < ApplicationController
  before_action :already_signed_in, only: [:new]
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      login_user!
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  def show
    @user = User.find_by(session_token: session[:session_token])
    render :show
  end
  
  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
  
  def already_signed_in
    redirect_to user_url if current_user
  end
end