class ChatroomsController < ApplicationController
  before_action :authenticate_user!
  # before_action :find_chatroom, only: [:show, :edit, :update, :destroy]
  
  def index
    # 친그라운드에서는 자기가 참여한 곳에만 채팅 구현
    @my_chatrooms = current_user.chatrooms.reverse
  end

  def show
    # @messages = chatroom.messages.reverse
  end

  def new
    # get '/article/article_id/chatroom/new'
  end

  # post '/article/article_id/chatroom/create'
  # 게시물 작성 시 자동으로 채팅방 생성되도록 만들어야함.
  def create
    @chatroom = Chatroom.new(chatroom_params)
    # 생성하면서 게시물의 참여자들을 자동으로 참여시켜야함
    users_list = ArticleUser.where(article_id: params[:article_id].to_i)
    users_list.each do |articleuser|
      @chatroom.users << User.find(articleuser.user_id)
    end
    @chatroom.save
    redirect_to "/chatroom/index"
  end

  def edit
  end

  def update
    @chatroom.name = chatroom_params[:name]
    @chatroom.save
  end

  def destroy
    @chatroom.destroy
  end

  def participate
  end

  def participate_cancel
  end
  
  private
  def find_chatroom
    @chatroom = Chatroom.find(params[:id])
  end
  def chatroom_params
    params.require(:chatroom).permit(:name)
  end
end
