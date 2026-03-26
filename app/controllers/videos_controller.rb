class VideosController < ApplicationController
  def index
    @videos = Video.published.by_category(params[:category])
    @categories = Video.distinct.pluck(:category).compact

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
    @video = Video.find(params[:id])
    @comments = @video.comments.approved.order(created_at: :desc)
    @comment = Comment.new
  end
end
