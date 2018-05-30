class FreechatsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_freechat, only: [:show]
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
  
  private
  def find_freechat
    @freechat  = Freechat.find(params[:id])
  end
end
