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
      render 'new'
    end
  end

  def index
    @roles = Role.all
    # @user = User.find(session[:user_id])
    authorize @roles
  end

  def edit
    @role = Role.find(params[:id])
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
    @role.destroy
    flash[:error] = 'Role deleted'
    redirect_to roles_path
  end

  private

  def role_params
    params.require(:role).permit(:rolename)
  end

  def find_role
    @role = Role.find(params[:id])
  end
end
