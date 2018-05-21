class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
  
  def speak(data)
    message = Message.new
    message.user_id = 2
    message.article_id = 1
    message.content = data["message"]
    message.save
  end
end