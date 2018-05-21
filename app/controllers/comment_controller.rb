class CommentController < ApplicationController
  before_action :authenticate_user!
  def create
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.article_id = params[:id]
    comment.save
    # 일단 구현해 본 뒤 모든 참가자한테 알림이 뜨도록 수정할 수 있을 듯....
    @new_notification = NewNotification.create! user: User.find(Article.find(params[:id]).user_id),
                        content: "#{current_user.email}님이 댓글을 달았습니다.",
                        link: "/article/show/#{params[:id]}"
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
