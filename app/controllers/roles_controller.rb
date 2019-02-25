class RolesController < ApplicationController
  before_action :find_role, only: [:update]
  def new
    @role=Role.new
  end
  
  def create
    @role=Role.new(role_params)
    if @role.save!
      flash[:notice] = "Role was created successfully"
      redirect_to roles_path
    else
      render 'new'
    end
  end
  def index
    @roles = Role.all
    @user = User.find(session[:user_id])
    authorize @user
  end
  def edit
    @role=Role.find(params[:id])
  end
  def update
    if @role.update (role_params)
      flash[:notice] = "Role was updated successfully"
      redirect_to roles_path
    else
      render 'edit'
    end
  end
  private
  def role_params
    params.require(:role).permit(:rolename)
  end
  def find_role
    @role=Role.find(params[:id])
  end
end