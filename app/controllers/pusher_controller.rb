class PusherController < ApplicationController
  before_action :authenticate_user!

  def auth
    raise BadRequest unless params[:channel_name] == current_user.pusher_channel
    auth = Pusher.authenticate(params[:channel_name], params[:socket_id])

    render json: auth
  end
end
