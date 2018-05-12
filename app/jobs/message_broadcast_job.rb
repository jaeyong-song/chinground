class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast 'chat_channel', message: render_message(message)
    # 바로 보여주는 job이 아니고 렌더하여 보여줄 것!
    # Do something later
  end
  
  private
  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: {message:message})
    # ApplicationController 내의 메소드 활용
    # partial form 이용하여 예쁘게 렌더
    # message라는 변수를 넘겨줌
  end
end
