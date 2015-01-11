class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  helper_method :current_user, :logged_in?

  def logged_in?
  	!!current_user
  end

  def current_user
  	@current_user ||= User.find_by_id(session[:user_id])
  end

  def require_user
    unless logged_in?
      redirect_to login_path
      flash[:error] = "You must be logged in to do that."
    end
  end


  protect_from_forgery with: :exception
end
