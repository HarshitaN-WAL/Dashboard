class ProjectChannel < ApplicationCable::Channel
  def subscribed
    stream_from "project_#{params[:project_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
