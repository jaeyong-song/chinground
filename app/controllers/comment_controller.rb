class CommentController < ApplicationController
  before_action :authenticate_user!
  def create
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.article_id = params[:id]
    comment.save
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
