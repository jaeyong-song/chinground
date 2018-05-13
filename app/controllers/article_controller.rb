class ArticleController < ApplicationController
  before_action :authenticate_user!
  before_action :find_params, only: [:show, :edit, :destroy]
  before_action :match_user, only: [:edit, :destroy]
  # 글 수정 및 삭제 시 자신의 글이 아니면 삭제 및 수정이 되지 않도록.
  # [OPTIMIZE] 현재 임시로 만들어 놓았고 문제 없나 확인해야함.
  def index
    @articles = Article.all
  end
  
  def new
  end
  
  def create
    Article.create({title: params[:title], content: params[:content], \
    init_time: params[:init_time], fin_time: params[:fin_time], \
    place: params[:place], user: current_user})
    #should include user input by. current_user method
    redirect_to '/article'
  end
  
  def show
    # 작성한 user 에 대해서 알려줘야함
    @user = User.find(@article.user_id)
    # 현재 이 article에 참여한 사람 목록 지정하여 보내줄 것!
    @participants_all = ArticleUser.all
    @participants = [] # 참여하는 사람 계정이름
    @participants_all.each do |participant|
      if @article.id == participant.article_id
        @participants << User.find(participant.user_id).email
      end
    end
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
    Article.update(params[:id], {title: params[:title], content: params[:content], \
    init_time: params[:init_time], fin_time: params[:fin_time], \
    place: params[:place], user: current_user})
    redirect_to '/article'
  end
  
  # user들이 게시물에 참여할 수 있도록 하는 메소드
  def participate
    ArticleUser.create({ article_id: params[:article_id], user_id: params[:user_id] })
    redirect_to "/article/show/#{params[:id]}"
  end
  
  # user들이 게시물 참여 취소할 수 있도록 하는 메소드
  def participate_cancel
    @articleusers = ArticleUser.all
    @articleusers.each do |articleuser|
      if (articleuser.article_id == params[:article_id].to_i) && (articleuser.user_id == params[:user_id].to_i)
        articleuser.destroy # 관계 삭제
        flash[:success] = "참여가 취소되었습니다"
      end
    end
    redirect_to "/article/show/#{params[:id]}"
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
end
