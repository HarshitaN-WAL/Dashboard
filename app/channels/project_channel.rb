# class ProjectChannel < ApplicationCable::Channel
#   def subscribed
#     if params[:project_id]
#         stream_from "project_#{params[:project_id]}"
#     end
#   end

#   def unsubscribed
#     # Any cleanup needed when channel is unsubscribed
#   end
# end
