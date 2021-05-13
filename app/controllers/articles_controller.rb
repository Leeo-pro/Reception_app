class ArticlesController < ApplicationController
  # before_action :set_item, only: [:index]
  #before_action :set_articles, only: [:index]
  #before_action :set_user, only: [:index]
  
  def new
    @user = User.find(params[:user_id])
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = "関連ニュースを更新しました。"
      redirect_to user_articles_path
    else
      render :new
    end
  end
  
  def index
    @user = User.find(params[:user_id])
    @article = Article.new
    @artciles_latest3 = Article.order(created_at: :desc).limit(4)
    @articles_offset3 = Article.offset(9)
  end
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:success] = "データを削除しました。"
    redirect_to user_articles_url
  end
  
  private
    def article_params
      params.require(:article).permit(:news_id, :memo)
    end
    
    def set_item
      @item = Article.find(params[:id])
    end
    
    def set_articles
      @articles = Articles.order(created_at: :desc)
    end
end
