class RatingController < ApplicationController
  before_action :authenticate_user!
  before_action :find_params, only: [:show, :edit, :destroy]
  before_action :match_user, only: [:edit, :destroy]
  
  def index
    @ratings = Rating.all
    @usr_ratings_avg = avg_ratings(current_user.id)
    #[TODO] 이용자별로 별점 걸려야함
    # 현재는 현재 사용자 기준으로 볼 수 있도록 하였음... 추후에 기능 개선 필요함
  end

  def new
  end

  def create
    Article.create({title: params[:title], content: params[:content], user: current_user})
    #should include user input by. current_user method
    redirect_to '/article'
  end

  def show
  end

  def destroy
    @article.destroy
    flash[:success] = "게시글 삭제가 완료되었습니다."
    #플래시 메시지로 삭제 완료 알려줌.
    #bootstrap 플래시 메시지 공통 양식으로 적용
    #views/shared/_flash_messages.html.erb에 공통 양식 있음.
    redirect_to '/article'
  end

  def edit
  end

  def update
    Article.update(params[:id], {title: params[:title], content: params[:content]})
    redirect_to '/article'
  end
  
  private
  
  def find_params
    @article = Article.find(params[:id])
  end
  
  # prevent another user from destroy or edit article
  def match_user
    if @article.user != current_user
      flash[:error] = "삭제 및 수정 권한이 없습니다"
      #권한 없음 플래시 메시지
      redirect_to '/article'
    end
  end
  
  # 평균 평점 계산하여 주는 private 함수
  def avg_ratings(user_id)
    @ratings_tmp = [] # user와 관련된 평점 걸러주는 tmp arr
    @ratings.each do |rating|
      # 만약에 현재 유저와 별점의 아이디가 같으면 tmp arr에 추가
      if rating[:user_id] == user_id
        @ratings_tmp << rating
      end
    end
    ratings_sum = 0
    @ratings_tmp.each do |rating|
      ratings_sum += rating.rate
    end
    # data가 존재하지 않을 수 있음 이경우에는 0
    if @ratings_tmp.length == 0
      return 0
    else
      return ratings_sum / @ratings_tmp
    end
  end
end
