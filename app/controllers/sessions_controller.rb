class SessionsController < ApplicationController
    before_action :check_login , only: [:new]
    def new; end

    def create
        user = User.find_by(username: params[:session][:username])
        if user.nil?
            redirect_to signup_path and return
        end
        if user && user.authenticate(params[:session][:password])
            cookies.signed[:user_id] = user.id
            session[:user_id] = user.id
            flash[:success] = "You have logged in successfully"
           
            redirect_to projects_path
        else
            flash.now[:danger]="Something is wrong in your login"
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

end