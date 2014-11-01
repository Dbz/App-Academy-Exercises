class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password]) 
    if @user
      @user.reset_session_token!
      session[:session_token] = @user.session_token
      redirect_to user_url
    else
      render :new
    end
  end
  
  def destroy
    session[:session_token] = nil
    @user = User.new
    redirect_to new_session_url
  end
  
  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end