class HomeController < ApplicationController
  def index
    @featured_videos = Video.published.featured.limit(3)
    @latest_videos = Video.published.limit(3) if @featured_videos.empty?
    @videos = @featured_videos.presence || @latest_videos

    @featured_posts = Post.published.featured.limit(2)
    @latest_posts = Post.published.limit(2) if @featured_posts.empty?
    @posts = @featured_posts.presence || @latest_posts

    @books = Book.limit(3)
  end
end
