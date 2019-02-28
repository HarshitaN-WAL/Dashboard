class ApplicationController < ActionController::Base
  include Pundit
  helper_method :current_user, :logged_in?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :require_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end


  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to logout_path
  end


  def require_user
    if !logged_in?
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
end
