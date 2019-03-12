# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :require_user, only: %i[new create]
  before_action :check_login, only: [:new]
  def new; end

  def create
    @user = find_user
    redirect_to(signup_path) && return if @user.nil?
    if @user&.authenticate(params[:session][:password])
      log_user
      if @user.rolename == "Admin"
        redirect_to roles_path
      else
        redirect_to projects_path
      end
    else
      flash.now[:danger] = 'Something is wrong in your login'
      render 'new'
    end
  end

  def destroy
    cookies.delete :user_id
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def check_login
    redirect_to projects_path if logged_in?
  end

  def find_user
    User.find_by(username: params[:session][:username])
  end

  def create_session
    session[:user_id] = @user.id
  end

  def create_cookie
    cookies.signed[:user_id] = @user.id
  end

  def log_user
    create_session
    create_cookie
    assign_role
    flash[:success] = 'You have logged in successfully'
  end

  def assign_role
    @role = @user.rolename
  end
end
