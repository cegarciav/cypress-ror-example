class ArticlesController < ApplicationController
  def create
    if !(session[:username] && User.find_by(username: session[:username]))
      redirect_to '/'
    end

    new_article_params = params.permit(
      :title,
      :description,
      :image_url,
      :authenticity_token,
      :commit
    )

    if new_article_params[:title].length < 1
      flash[:notice] = 'Title must be at least 1 character long'
      redirect_to '/articles/new'
    else
      begin
        @article = Article.create!(
          title: new_article_params[:title],
          description: new_article_params[:description],
          image_url: new_article_params[:image_url]
        )
        redirect_to '/'
      rescue
        flash[:notice] = 'Something went wrong. Check the content and try again'
        redirect_to '/articles/new'
      end
    end
  end

  def index
    @articles = Article.all.order(created_at: :desc)
  end

  def new
    if !(session[:username] && User.find_by(username: session[:username]))
      redirect_to '/'
    end
  end
end
