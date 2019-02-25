class MessagesController < ApplicationController
  before_action :require_user

  def create
    message = current_user.messages.build(message_params)
    if message.save
      # redirect_to chatroom_index_path
      ActionCable.server.broadcast "chatroom_channel", message_sent: message_render(message)
    end
  end

  private
  def message_params
    params.require(:message).permit(:body)    
  end

  def message_render(message)
    # byebug
    render(partial: 'message', locals: {message: message})
  end
end