class VideosController < ApplicationController
  def index
    @videos = Video.published.by_category(params[:category]).by_channel(params[:channel])
    @categories = Video.distinct.pluck(:category).compact
    @channels = YoutubeChannel.joins(:videos).distinct.order(:name)

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
