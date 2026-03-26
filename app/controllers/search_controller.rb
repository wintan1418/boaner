class SearchController < ApplicationController
  def index
    @query = params[:q].to_s.strip
    if @query.present?
      @videos = Video.where("title ILIKE :q OR description ILIKE :q", q: "%#{@query}%").order(published_at: :desc)
      @posts = Post.where("title ILIKE :q OR excerpt ILIKE :q", q: "%#{@query}%").order(published_at: :desc)
      @books = Book.where("title ILIKE :q OR description ILIKE :q", q: "%#{@query}%")
    else
      @videos = Video.none
      @posts = Post.none
      @books = Book.none
    end
  end
end
