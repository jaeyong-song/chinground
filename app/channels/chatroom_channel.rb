class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_#{params[:room]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create! content: data["message"], user_id: current_user.id, chatroom_id: params[:room]
  end
end
