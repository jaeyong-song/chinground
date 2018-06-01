class RatingController < ApplicationController
  before_action :authenticate_user!
  def index
      # 사용자의 평균 별점 보여주기
      @my_avg = RatingController.avg_rating(current_user.id)
      # [OPTIZIZE] 나중에 m:n 구조 model helper로 간단하게 만들기
      # 내가 참여한 것 중 끝난 게시물에 대한 코드
      # 1. 평가를 미완료 한 것 모아주기 (wait_list)
      # 2. 평가를 완료한 것 모아주기 (fin_list)
      my_joins = RatingController.find_my_joined(current_user.id)
      # 내가 참여한 모임(id) 중 끝난 모임이 my_joins에 들어있음
      @fin_list = RatingController.find_my_ratings(current_user.id)
      # 내가 평가 완료한 모임이 fin_list에 들어있음
      @wait_list = my_joins - @fin_list
      # 내가 평가 완료하지 못한 모임이 wait_list에...
  end
  def new
    # params[:id]에 별점 평가할 게시물 id가 넘어온 상태
    # 참여한 사람에서 자기 자신은 평가할 수 없도록 해야하기 때문에 주의!!
    @joined_users = find_participants(params[:id].to_i) - [current_user.id]
    @article_id = params[:id]
  end
  def create
    # 현재 params[:id]에 게시물 id
    # hash로 user_id: rating 형태로 여러명의 평점 넘어온 상태
    joined_users = find_participants(params[:id].to_i) - [current_user.id]
    # 몇번 create 메소드를 실행해야하는지 계산하여 실행
    joined_users.each do |id|
      Rating.create({ evaluator: current_user.id, user_id: id, \
      article_id: params[:id], rate: params["#{id}"] })
    end
    flash[:success] = "별점 부여가 완료되었습니다"
    redirect_to '/rating'
  end
  
  def find_participants(article_id)
    participants = []
    @articleusers = ArticleUser.all
    @articleusers.each do |articleuser|
      if articleuser.article_id == article_id
        participants << articleuser.user_id
      end
    end
    return participants
  end
  # 내가 평가한 게시물 찾기
  def self.find_my_ratings(user)
    @ratings = Rating.all
    my_rated_article = [] # 내가 평가한 게시물(id) 저장
    @ratings.each do |rating|
      if rating.evaluator == user
        my_rated_article << rating.article_id
      end
    end
    # 한 게시물에 여러사람에게 평점을 주므로 uniq 메소드 이용
    return my_rated_article.uniq
  end
  # 내가 참여했던 게시물 찾기
  def self.find_my_joined(user)
      my_joins = []
      @articleusers = ArticleUser.all
      @articleusers.each do |articleuser|
          if articleuser.user_id == user
            if Article.find(articleuser.article_id).active == false
              my_joins << articleuser.article_id
            end
          end
      end
      return my_joins.uniq
  end
  
  # 내가 참여하고 있는 게시물 찾기
  def self.find_my_joining(user)
      my_joins = []
      @articleusers = ArticleUser.all
      @articleusers.each do |articleuser|
          if articleuser.user_id == user
            if Article.find(articleuser.article_id).active == true
              my_joins << articleuser.article_id
            end
          end
      end
      return my_joins.uniq
  end
  
  # 사용자 평균 별점 계산 코드
  def self.avg_rating(user)
      @ratings = Rating.all
      my_ratings = []
      @ratings.each do |rating|
          if rating.user_id == user
            my_ratings << rating.rate
          end
      end
      # rating이 없는 경우 반영
      if my_ratings.length != 0
          return my_ratings.sum / my_ratings.length
      else
          return 0
      end
  end
end