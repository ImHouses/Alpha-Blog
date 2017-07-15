class ArticlesController < ApplicationController

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  # POST method for articles.
  def create
    @article = Article.new(article_params)
    @article.user = User.first
    if @article.save
      flash[:notice] = "Article was successfully displayed"
      redirect_to @article
    else
      flash[:notice] = article_errors @article
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "Article was successfully edited"
      redirect_to @article
    else
      flash[:notice] = article_errors @article
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  # Display article.
  def show
    @article = Article.find(params[:id])
  end

  private
    # Allow only title and description fields.
    def article_params
      params.require(:article).permit(:title, :description)
    end

    # Return a string with all the errors.
    def article_errors article
      s = ""
      article.errors.full_messages.each do |msg|
        s += "#{msg} "
      end
      return s
    end
end
