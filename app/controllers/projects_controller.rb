require 'net/http'

class ProjectsController < ApplicationController

  before_action :find_project, only: %i[show update destroy]
  # before_action :users_roles, only: %i[new create]

  def new
    @project = Project.new
    @project.repos.build
    authorize @project
    users_roles
  end

  def create
    @project = Project.new(project_params)
    if @project.save! 
      if save_project_user
        flash[:success] = 'Project was successfully created'
        redirect_to project_path(@project)
      end
    else
      message = "Project was not created because #{@project.errors.full_messages}"
      flash.now[:error] = message
      users_roles
      render 'new'
    end
  end

  def index
      @role = User.find(session[:user_id]).rolename
      if @role == 'Top Management' || @role == 'Admin'
        @project = Project.all.page params[:page]
      else
        user_id = session[:user_id]
        @project = Project.includes(users: :role).where(users: { id: user_id }).page params[:page]   
      end
  end

  def edit
    edit_project
  end

  def update
    if @project.update project_params
      # @project.save!
      @working_users = user_includes.where(project_users: { project_id: @project.id, active: 1 })
                                    .pluck(:id)
      save_project_user if params[:user_id].map(&:to_i) - @working_users
      delete_user if @working_users - params[:user_id].map(&:to_i)
      flash[:success] = 'Project was updated successfully'
      redirect_to project_path(@project)
    else
      edit_project
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    flash[:notice] = 'Project deleted'
    redirect_to projects_path
  end

  def show
    @users_list = @project.users.where(project_users: { active: 1 }).group_by(&:rolename)
    @roles = @users_list.keys
    if check_pivotal_tracker
      begin
        @bugs = PivotalTrackerJob.perform_now @project.id
      rescue TrackerApi::Errors::ClientError => e
        @pt_error = "There is a pivotal tracker error"
        puts "#{e.class}  #{e.message}"
      end
    else
      @bugs = 0
    end
    if check_code_quality
      begin
        @image_url = code_climate
      rescue ClimateError => e
        # puts "#{e.message}"
        @code_climate_error = "Please check your code climate"
      end
    else
      @image_url = nil
    end
    if !@project.repos.blank?
      @repos_list = @project.repos
    end
    @message = Message.new
    @messages = @project.messages
  end

  private

  def project_params
    permit_params = %i[name start_date expected_target_date pt_token project_token quality_token github_slug client]
    params.require(:project).permit(permit_params, repos_attributes: [:link, :_destroy, :id])
  end

  def find_project
    @project = Project.includes(users: :role).find(params[:id])
  end

  def delete_user
    @users = @working_users - params[:user_id].map(&:to_i)
    deactivate_user
  end

  def save_project_user
    if params[:user_id]
      if @working_users
        @update_users = @project.project_users.pluck(:user_id) - @working_users
        @user = params[:user_id].map(&:to_i) - @working_users - @update_users
        user_activate
      else
        @user = params[:user_id]
      end
      @user.each do |i|
        @project.project_users.create!(user_id: i, active: 1)
      end
    end
  end

  def check_pivotal_tracker
    !@project.pt_token.blank? && !@project.project_token.blank?
  end

  def check_code_quality
    !@project.quality_token.blank? && !@project.github_slug.blank?
  end

  def user_activate
    @update_users&.each do |i|
      @project.project_users.where(project_users: { user_id: i }).update(active: 1)
    end
  end

  def deactivate_user
    @users.each do |i|
      @project.project_users.where(project_users: { user_id: i }).update(active: 0)
    end
  end

  def user_includes
    User.includes(:project_users)
  end

  def users_roles
    @user_list = User.includes(:role).group_by(&:rolename).reject {|k| k=="Admin"}
    @roles = @user_list.keys
    @action = 'new'
  end

  def code_climate
    ProjectService.new.code_quality(@project)
  end

  def edit_project
    @project = Project.find(params[:id])
    @project.repos.build if @project.repos.blank?
    @user_list = User.includes(:role).group_by(&:rolename).reject {|k| k=="Admin"}
    @roles = @user_list.keys
    users = user_includes.where(project_users: { project_id: @project.id, active: 1 })
    @role_users = users.group_by(&:rolename)
    @action = check_pivotal_tracker
  end
end
