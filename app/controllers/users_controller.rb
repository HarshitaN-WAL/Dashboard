class UsersController < ApplicationController
  skip_before_action :require_user, only: %i[sign_up_new sign_up_create]
  before_action :find_user, only: %i[show destroy edit update]
  def new
    @user = User.new
    authorize @user
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      # @user.avatar.attach(params[:avatar])
      flash[:success] = 'user was created successfully'
      UserMailer.welcome_email(@user).deliver_later
      redirect_to user_path(@user)      
    else
      flash[:notice] = "user was not created #{@user.errors.full_messages}"
      render 'new'
    end
  end

  def sign_up_new
    @user = User.new
  end
  
  def sign_up_create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Please login to continue'
      UserMailer.welcome_email(@user).deliver_later
      redirect_to root_path
    else
      flash[:notice] = "user was not created #{@user.errors.full_messages}"
      render 'new'
    end
  end

  def show
    @role = @user.rolename
  end

  def index
    # byebug
    @users = User.all.page params[:page]
    authorize @users
  end

  def destroy
    @user.destroy
    flash[:notice] = 'User Destroyed'
    redirect_to users_path
  end

  def edit
    @user
  end

  def download
    send_file 'path', type: 'name/format', x_sendfile: true
  end

  def update
    if @user.update user_params
      flash[:success] = 'User was updated successfully'
      redirect_to user_path(@user)
    else
      flash[:notice] = "#{@user.errors.full_messages}"
      render 'edit'
    end
  end

  private

  def user_params
    permit_params = %i[username email role_id password avatar]
    params.require(:user).permit(permit_params)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
