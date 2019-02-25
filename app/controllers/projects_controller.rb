class ProjectsController < ApplicationController
	before_action :find_project, only: [:show, :update, :destroy]
	# after_action :save_project_user, only:[:create]

	def new
		@project = Project.new
    	authorize @project
		@user_list = User.includes(:role).group_by(&:rolename)
		@roles=@user_list.keys
	    @action = "new"
	end

	def index
		if session[:user_id]
			@role = User.find(session[:user_id]).rolename
			if(@role != "Top Management")
				@project= Project.includes(users: :role).where(users:{id:session[:user_id]})
			else
				@project = Project.all
			end
		else
			@project = Project.all
		end
	end

	def edit
		@project = Project.find(params[:id])
		@user_list = User.includes(:role).group_by(&:rolename)
		@roles=@user_list.keys
		@role_users = User.includes(:project_users).where(project_users:{project_id:@project.id, active: 1}).group_by(&:rolename)
	end

	def create
		# render plain: params[:project].inspect

		 @project = Project.new(project_params)
     byebug
  	if @project.save && save_project_user
  		 	flash[:success] = "Project was successfully created"
  			redirect_to project_path(@project)
    else
      flash.now[:error] = "Project was not created"
      @user_list = User.includes(:role).group_by(&:rolename)
      @roles = @user_list.keys
      @action = "new"
  		render 'new'
  	end
  			# redirect_to project_path(@project)
	end

	def destroy
		@project.destroy
		flash[:notice] = "Project deleted"
		redirect_to projects_path
	end

	def update
		if @project.update (project_params)
			@working_users = User.includes(:project_users).where(project_users:{project_id:@project.id, active: 1}).pluck(:id)
			save_project_user if params[:user_id].map(&:to_i) - @working_users
			delete_user if @working_users - params[:user_id].map(&:to_i)
			flash[:success
      ] = "Project was updated successfully"
			redirect_to project_path(@project)
		else
			render 'edit'
		end
	end

	def show
		# @users=@project.users.pluck(:username).join(',')
		@users_list = @project.users.where(project_users:{active: 1}).group_by(&:rolename)
		@roles = @users_list.keys
	    if check_project_token
			@bugs = ProjectService.new.stats(@project)
		else
	      @count_bugs = 0
    end
    # @number_of_developer = @users.group_by(&:rolename)["Developer"].length 
	end

	private

	def project_params
		params.require(:project).permit(:name, :start_date, :expected_target_date, :pt_token, :project_token)
	end

	def find_project
		@project = Project.includes(users: :role).find(params[:id])
		# @project=Project.find(params[:id])
	end

	def delete_user
		@users = @working_users - params[:user_id].map(&:to_i)
		@users.each do |i|
			@project.project_users.where(project_users:{user_id: i}).update(active: 0)
		end	
	end

	def save_project_user
		# @project_user = ProjectUser.create!(user_id: params[:user_id], project_id: @project.id)
		if @working_users
			@update_users = @project.project_users.pluck(:user_id) - @working_users
			@user = params[:user_id].map(&:to_i) - @working_users - @update_users
			if @update_users
				@update_users.each do |i|
					@project.project_users.where(project_users:{user_id: i}).update(active: 1)
				end
			end
		else
			@user = params[:user_id] 
		end
		p @user
		@user.each do |i|
		@project_user = @project.project_users.create!(user_id: i, active: 1)

		end
	end

	# To check if the project has id in PT
	def check_project_token
		@project.project_token != "" && @project.project_token != nil
	end


end