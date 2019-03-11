# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :require_user

  def create
    message = Project.find(params[:project_id]).messages.build(message_params)
    message.user_id = current_user.id
    if message.save
      # redirect_to chatroom_index_path
      ActionCable.server.broadcast "project_#{params[:project_id]}", message_sent: message_render(message)
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  def message_render(message)
    render(partial: 'message', locals: { message: message })
  end
end
