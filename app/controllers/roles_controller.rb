# frozen_string_literal: true

class RolesController < ApplicationController
  before_action :find_role, only: %i[show update destroy]
  def new
    @role = Role.new
    authorize @role
  end

  def create
    @role = Role.new(role_params)
    if @role.save!
      flash[:notice] = 'Role was created successfully'
      redirect_to roles_path
    else
      @role = Role.new
      authorize @role
      render 'new'
    end
  end

  def index
    @roles = Role.all.order(:id)
    # @user = User.find(session[:user_id])
    authorize @roles
  end

  def edit
    if Role.find(params[:id]).rolename != "Admin" && Role.find(params[:id]).rolename != "Top Management"
      @role = Role.find(params[:id])
    else
      flash.now[:error] = "Action not allowed"
      @roles = Role.all
      render 'index'
    end
  end

  def update
    if @role.update role_params
      flash[:success] = 'Role was updated successfully'
      redirect_to roles_path
    else
      render 'edit'
    end
  end

  def destroy
    if @role.rolename != "Admin" && @role.rolename != "Top Management"
      @role.destroy
      flash[:error] = 'Role deleted'
      redirect_to roles_path
    else
      flash.now[:error] = "Action not allowed"
      @roles = Role.all
      render 'index'
    end
  end

  private

  def role_params
    params.require(:role).permit(:rolename)
  end

  def find_role
    @role = Role.find(params[:id])
  end
end
