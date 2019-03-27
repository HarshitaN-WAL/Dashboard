class UsersController < ApplicationController
  skip_before_action :require_user, only: %i[sign_up_new sign_up_create]
  before_action :find_user, only: %i[show destroy edit update]
  def new
    @user = User.new
    @role = Role.all - Role.where(rolename: "Admin")
    authorize @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # @user.avatar.attach(params[:avatar])
      flash[:success] = 'user was created successfully'
      UserMailer.welcome_email(@user).deliver_later
      redirect_to user_path(@user)      
    else
      flash.now[:error] = "user was not created #{@user.errors.full_messages.join(',')}"
      @user = User.new
      @role = Role.all - Role.where(rolename: "Admin")
      render 'new'
    end
  end

  def sign_up_new
    @user = User.new
    @role = Role.all - Role.where(rolename: "Admin")
  end
  
  def sign_up_create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Please login to continue'
      UserMailer.welcome_email(@user).deliver_later
      redirect_to root_path
    else
      flash.now[:error] = "User was not created #{@user.errors.full_messages.join(',')}"
      @user = User.new
      @role = Role.all - Role.where(rolename: "Admin")
      render 'sign_up_new'
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
    authorize @user
    @user.destroy
    flash.now[:error] = 'User Destroyed'
    redirect_to users_path
  end

  def edit
    unless current_user == @user
     user_not_authorized
    end
    if @user.username != "Admin"
    @role = Role.all - Role.where(rolename: "Admin")
    else
      redirect_to users_path
    end    
  end

  def download
    send_file 'path', type: 'name/format', x_sendfile: true
  end

  def update
    if @user.update user_params
      flash[:success] = 'User was updated successfully'
      redirect_to user_path(@user)
    else
      flash.now[:error] = "#{@user.errors.full_messages.join(',')}"
      @role = Role.all - Role.where(rolename: "Admin")
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
