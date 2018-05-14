class RatingController < ApplicationController
  def index
      # 사용자의 평균 별점 보여주기
      @my_avg = avg_rating(current_user.id)
      # 내가 참여한 것 중 끝난 게시물에 대한 코드
      # 1. 평가를 미완료 한 것 모아주기 (wait_list)
      # 2. 평가를 완료한 것 모아주기 (fin_list)
      @articles = Article.all
      @articleusers = ArticleUser.all
      my_ratings = []
      @articleusers.each do |articleuser|
          if articleuser.user_id == user
            my_ratings << articleuser.rate
          end
      end
      
      
  end
  def new
  end
  def create
  end
  
  private
  # 내가 참여한 게시물 찾기
  def find_my_joins(user)
      my_joins = []
      @articleusers = ArticleUser.all
      @articleusers.each do |articleuser|
          if articleuser.user_id == current_user.id
            my_joins << articleuser.article_id
          end
      end
      # 사용자가 별점을 먹이는 것이 한 게시물에 많기 때문에 중복 제거
      my_joins = my_joins.uniq
  end
  # 사용자 평균 별점 계산 코드
  def avg_rating(user)
      @ratings = Rating.all
      my_ratings = []
      @ratings.each do |rating|
          if rating.user_id == user
            my_ratings << rating.rate
          end
      end
      # rating이 없는 경우 반영
      if my_ratings != nil
          return my_ratings.sum / my_ratings.length
      else
          return 0
      end
  end
end