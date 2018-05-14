class ArticleController < ApplicationController
  before_action :authenticate_user!
  before_action :find_params, only: [:show, :edit, :destroy, :participate_cancel]
  before_action :match_user, only: [:edit, :destroy]
  # 글 수정 및 삭제 시 자신의 글이 아니면 삭제 및 수정이 되지 않도록.
  # [OPTIMIZE] 현재 임시로 만들어 놓았고 문제 없나 확인해야함.
  def index
    @articles = Article.all
  end
  
  def new
  end
  
  def create
    article_tmp = Article.create({title: params[:title], content: params[:content], \
    init_time: params[:init_time], fin_time: params[:fin_time], \
    place: params[:place], user: current_user})
    # 만약에 게시글을 생성하면 본인은 자동으로 추가되도록 만들 것
    ArticleUser.create({ article_id: article_tmp.id, user_id: current_user.id })
    #should include user input by. current_user.id method
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
    # 참여 취소하지 않고 바로 게시글 삭제 시
    # 다른 사람들끼리 모이고 싶어도 모일 수 없기 때문에 예외처리 필요
    # [OPTIMIZE] 구현은 완료했고 더 깔끔하게 정리 필요
    articleusers = ArticleUser.all
    judge_int = 0
    articleusers.each do |articleuser|
      if articleuser.article_id == @article.id
        judge_int += 1
      end
    end
    # 본인 외에 다른 사람이 참여하고 있으면
    if judge_int > 1
      flash[:error] = "다른 사람이 참여하고 있을 때는 참여취소 후 게시물 권한 넘기기만 가능합니다"
      redirect_to "/article/show/#{params[:id]}"
    else
    # 그렇지 않다면
      @article.destroy
      flash[:success] = "게시글 삭제가 완료되었습니다."
      #플래시 메시지로 삭제 완료 알려줌.
      #bootstrap 플래시 메시지 공통 양식으로 적용
      #views/shared/_flash_messages.html.erb에 공통 양식 있음.
      redirect_to '/article'
    end
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
    flash[:success] = "참여가 완료되었습니다"
    redirect_to "/article/show/#{params[:id]}"
  end
  
  # user들이 게시물 참여 취소할 수 있도록 하는 메소드
  def participate_cancel
    # [OPTIMIZE] 구현은 했는데 나중에 깔끔하게 정리 필요
    # 만약에 게시물 작성 본인이 참여 취소했을 경우에는 게시물 권한을 넘긴 후에
    # 참여 취소가 되어야한다. 이 때 원하는 사람 지정할 수 있도록...
    # before_action으로 게시글 @article에 저장한 상태
    # params[:passto_id] 로 넘겨줄 계정 이름 넘어온 상태
    users = User.all
    passto_user = nil
    users.each do |user|
      if user.email == params[:passto_id]
        passto_user = user.id
      end
    end
    @article.user_id = passto_user
    @article.save
    # ==================여기까지가 다른 사람에게 권한 넘기기
    # =======여기서부터 참여 관계 삭제
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
