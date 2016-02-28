class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @user = User.find(session[:user_id]) if session[:user_id]
  end

  def redirect_if_not_correct_user
    redirect_to current_user if @user.id != current_user.id
  end
end
