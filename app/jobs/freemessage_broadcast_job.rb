class FreemessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "freeroom_#{message.freechat_id}", message: render_message(message)
  end
  private
    def render_message(message)
      ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message, user: current_user })
    end  
end
