class FreechatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "freeroom_#{params[:room]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    FreeMessage.create! content: data["message"], user_id: current_user.id, freechat_id: params[:room]
  end
end
