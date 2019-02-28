class UsersController < ApplicationController
  before_action :find_user ,only: [:show ,:destroy ,:edit,:update ]
  def new
    @user=User.new
  end

  def create
    @user=User.new(user_params)
    puts @user.inspect
    if @user.save
      # @user.avatar.attach(params[:avatar])
      flash[:success]="user was created successfully"
      redirect_to user_path(@user)
      UserMailer.welcome_email(@user).deliver_later
    else
      flash[:notice]="user was not created"
      render "new"
    end 
  end

  def show
    @role=@user.rolename
  end

  def index
    @user=User.all
    authorize @user
  end

  def destroy
    @user.destroy
    flash[:notice]="User Destroyed"
    redirect_to users_path
  end

  def edit; end

  def download
    send_file 'path', type: "name/format", x_sendfile: true
    end

  def update
    if @user.update (user_params)
      flash[:success] = "User was updated successfully"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  private
  # def update_user_params
  #   params.require(:user).permit(:username, :email, :role_id, :password)
  # end
  def user_params
    params.require(:user).permit(:username, :email, :role_id, :password, :avatar)
  end

  def find_user
    @user=User.find(params[:id])
  end

end