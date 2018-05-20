class WelcomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
  end
  def mypage
    # 사용자의 평균 별점 보여주기
    @my_avg = RatingController.avg_rating(current_user.id)
    # [OPTIZIZE] 나중에 m:n 구조 model helper로 간단하게 만들기
    # 0. 전체 참여 게시물
    @my_all = WelcomeController.find_my_all(current_user.id).reverse
    # 내가 참여한 것 중 끝난 게시물에 대한 코드
    # 1. 평가를 미완료 한 것 모아주기 (wait_list)
    # 2. 평가를 완료한 것 모아주기 (fin_list)
    my_joins = RatingController.find_my_joined(current_user.id)
    # 내가 참여한 모임(id) 중 끝난 모임이 my_joins에 들어있음
    @fin_list = RatingController.find_my_ratings(current_user.id)
    # 내가 평가 완료한 모임이 fin_list에 들어있음
    @wait_list = my_joins - @fin_list
    # 내가 평가 완료하지 못한 모임이 wait_list에...
    
    #[TODO] 본인 프로필 보여주기, 본인이 참가한 총 게시물 등 통계 보여주기
  end
  
  def myground
    @my_all = WelcomeController.find_my_all(current_user.id).reverse
  end
  
  
  # 내가 참여한 전체 게시물 찾기
  def self.find_my_all(user)
      my_all = []
      @articleusers = ArticleUser.all
      @articleusers.each do |articleuser|
        if articleuser.user_id == user
            my_all << articleuser.article_id
        end
      end
      return my_all
  end
end
