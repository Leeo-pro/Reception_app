class ArticlesController < ApplicationController
  # before_action :set_item, only: [:index]
  #before_action :set_articles, only: [:index]
  #before_action :set_user, only: [:index]
  
  def new
    @categories = Category.all
    @user = User.find(params[:user_id])
    @article = Article.new(
      user_id: @user.id
      )
  end
  
  def create
    @user = User.find(params[:user_id])
    @article = @user.articles.new(article_params)
    if @article.save
      flash[:success] = "関連ニュースを更新しました。"
      redirect_to user_articles_path
    else
      flash[:danger] = "更新できませんでした。"
      render :new
    end
  end
  
  def index
    @user = User.find(params[:user_id])
    @articles = Article.all
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
  
  def edit_news_info
    @user = User.find(params[:user_id])
    @article = Article.find(params[:id])
  end

  def update_news_info
    @user = User.find(params[:user_id])
    @article = Article.find(params[:id])
    @article.user_id = params[:user_id]
    
    if @article.update_attributes(article_params)
      flash[:success] = "更新いたしました。"
    else
      flash[:danger] = "更新を中止しました。"
    end
    redirect_to user_articles_url
  end
  
  private
    def article_params
      params.require(:article).permit(:memo, :user_id)
    end
    
    def article_params2
      params.require(:article).permit(:memo)
    end
    
    def set_item
      @item = Article.find(params[:id])
    end
    
    def set_articles
      @articles = Articles.order(created_at: :desc)
    end
end
