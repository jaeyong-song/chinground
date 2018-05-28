class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [:show, :follow]
  def index
    @users = current_user.followed
  end

  # GET users/show/:id
  def show
  end

  def search
    @search = User.ransack(params[:q])
    @users = @search.result(distinct: true)
  end
  
  # 친구(팔로우 기능 구현)
  # POST users/:id/follow
  def follow
    @user.toggle_follow(current_user)
    redirect_back(fallback_location: root_path)
  end
  
  private
  def find_user
    @user = User.find(params[:id])
  end
end
