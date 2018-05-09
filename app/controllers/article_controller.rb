class ArticleController < ApplicationController
  before_action :authenticate_user!
  before_action :find_params, only: [:show, :edit, :destroy]
  def index
    @articles = Article.all
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
end
