module Admin
  class VideosController < BaseController
    before_action :set_video, only: [ :show, :edit, :update, :destroy ]

    def index
      @videos = Video.order(created_at: :desc)
      @videos = @videos.where("title ILIKE :q OR description ILIKE :q", q: "%#{params[:q]}%") if params[:q].present?
      @videos = @videos.where(category: params[:category]) if params[:category].present?
      @videos = @videos.where(youtube_channel_id: params[:channel]) if params[:channel].present?
      @categories = Video.distinct.pluck(:category).compact.sort
      @channels = YoutubeChannel.order(:name)
    end

    def show
      redirect_to edit_admin_video_path(@video)
    end

    def new
      @video = Video.new
    end

    def create
      @video = Video.new(video_params)
      if @video.save
        redirect_to admin_videos_path, notice: "Video created successfully."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @video.update(video_params)
        redirect_to admin_videos_path, notice: "Video updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @video.destroy
      redirect_to admin_videos_path, notice: "Video deleted."
    end

    private

    def set_video
      @video = Video.find(params[:id])
    end

    def video_params
      params.require(:video).permit(:title, :youtube_id, :description, :category, :published_at, :featured, :series_id, :youtube_channel_id)
    end
  end
end
