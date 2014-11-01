class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :login_user!, :current_user, :logged_in?, :log_in
  
  def login_user!
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    if @user
      @user.reset_session_token!
      session[:session_token] = @user.session_token
      redirect_to user_url
    else
      flash.now[:errors] = "Eeep! That's not a user"
      render :new
    end
  end
  
  def current_user
    User.find_by(session_token: session[:session_token])
  end
  
  def logged_in?
    current_user.is_a? User
  end
  
  def log_in
    redirect_to new_session_url unless logged_in?
  end
end
