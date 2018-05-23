class CommentController < ApplicationController
  before_action :authenticate_user!
  def create
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.article_id = params[:id]
    comment.save
    # 사용자들에게 댓글 달렸음 알려주는 알림 코드
    users_list = ArticleUser.where(article_id: params[:id].to_i) #user_list에 현재 article에 해당되는 사람 목록 저장
    users = [] # 실제 참가한 사람 id만 저장할 배열
    users_list.each do |articleuser|
     users << articleuser.user_id
    end
    # 알림 내역 저장을 참여한 모든 사람을 대상으로 진행해야함
    users.each do |user|
      @new_notification = NewNotification.create! user: User.find(user),
                          content: "#{params[:id]}번 글에 #{current_user.email}님이 댓글을 달았습니다.",
                          link: "/article/show/#{params[:id]}"
    end
    redirect_to "/article/show/#{params[:id]}"
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_back(fallback_location: root_path)
  end
  
  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
