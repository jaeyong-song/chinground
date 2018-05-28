class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [:show, :follow]
  def index
    @users = current_user.followers
  end

  # GET users/show/:id
  def show
    @joined_ids = RatingController.find_my_joined(@user)
    @joined = []
    @joined_ids.each do |id|
      @joined << Article.find(id)
    end
  end

  def search
    @search = User.ransack(params[:q])
    @users = @search.result(distinct: true)
  end
  
  # 친구(팔로우 기능 구현)
  # POST users/:id/follow
  def follow
    judge = @user.toggle_follow(current_user)
    if judge == -1
      flash[:error] ="본인과는 친구 관계를 맺을 수 없습니다"
    else
      # 팔로잉 한 사람에게 알림
      @new_notification = NewNotification.create! user: @user,
                          content: "#{current_user.email}님이 회원님을 팔로우/언팔로우했습니다",
                          link: "/users/show/#{current_user.id}"
      # 자신에게도 알림
      @new_notification = NewNotification.create! user: current_user,
                          content: "#{@user.email}님을 팔로우/언팔로우했습니다",
                          link: "/users/show/#{@user.id}"
    end
    redirect_back(fallback_location: root_path)
  end
  
  def myprofile
    @user = current_user
    @joined_ids = RatingController.find_my_joined(current_user)
    @joined = []
    @joined_ids.each do |id|
      @joined << Article.find(id)
    end
  end
  
  private
  def find_user
    @user = User.find(params[:id])
  end
end
