class FreechatsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_freechat, only: [:show, :add_users, :out]
  before_action :is_joiner, except: [:index, :new, :create]
  def index
    @my_freechats = current_user.freechats.reverse
  end

  def new
  end
  
  def create
    @freechat = Freechat.create(name: params[:name])  
    @freechat.users << current_user
    @freechat.save
    redirect_to "/freechats/show/#{@freechat.id}"
  end

  def show
  end
  
  # GET /freechats/new_users/:id
  def new_users
    @search = User.ransack(params[:q])
    @users = @search.result(distinct: true)
  end
  
  # POST /freechats/add_users/:id
  def add_users
    user = User.find(params[:user_id])
    # 만약에 초대 거부 상태가 아니라면
    unless @freechat.rejected_users.include?(user)
      @freechat.users << user
      @freechat.save
      @freechat.users.each do |u|
        @new_notification = NewNotification.create! user: u,
                            content: "#{@freechat.id}번 자유채팅에 #{u.email}님이 참가했습니다",
                            link: "/freechats/show/#{params[:id]}"
      end
      flash[:success] = "#{user.email}님이 채팅방에 추가되었습니다"
      redirect_to "/freechats/show/#{params[:id]}"
    else
      flash[:error] = "#{user.email}님은 초대거부 상태입니다"
      redirect_to "/freechats/index"
    end
  end
  
  def out
    @freechat.users.each do |u|
      @new_notification = NewNotification.create! user: u,
                          content: "#{@freechat.id}번 자유채팅에서 #{current_user.email}님이 나갔습니다",
                          link: "/freechats/index"
    end
    @freechat.users.delete(current_user)
    # 초대거부 상태 등록
    @freechat.rejected_users << current_user
    # 만약에 멤버가 한명도 없으면 이 채팅방 삭제되어야함
    if @freechat.users.count == 0
      @freechat.destroy
    end
    flash[:success] = "#{@freechat.id}번 자유채팅방에서 나오셨습니다"
    redirect_to "/freechats/index"
  end
  
  private
  def find_freechat
    @freechat  = Freechat.find(params[:id])
  end
  def is_joiner
    unless Freechat.find(params[:id]).users.include?(current_user)
      flash[:error] = "권한이 없습니다"
      redirect_back(fallback_location: root_path)
    end
  end
end