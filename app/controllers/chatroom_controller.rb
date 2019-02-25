class ChatroomController < ApplicationController
  before_action :require_user

  def index
    @project_id = params[:project_id]
    @message = Message.new
    @messages = Message.all
    end
end