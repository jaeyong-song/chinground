class ChatroomController < ApplicationController
  def show
    @messages = Message.all
  end
end
