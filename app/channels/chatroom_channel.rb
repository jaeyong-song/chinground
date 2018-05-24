class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "#{params[:id]}_channel"
    # 나중에 params[:id]로 수정
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    Message.create! content: data["message"], user_id: current_user.id, chatroom_id: params[:id]
  end
end
