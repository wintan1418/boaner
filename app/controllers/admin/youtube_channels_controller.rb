module Admin
  class YoutubeChannelsController < BaseController
    def index
      @channels = YoutubeChannel.all.order(:name)
    end

    def new
      @channel = YoutubeChannel.new
    end

    def create
      @channel = YoutubeChannel.new(channel_params)
      if @channel.save
        redirect_to admin_youtube_channels_path, notice: "Channel added."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @channel = YoutubeChannel.find(params[:id])
    end

    def update
      @channel = YoutubeChannel.find(params[:id])
      if @channel.update(channel_params)
        redirect_to admin_youtube_channels_path, notice: "Channel updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def sync
      @channel = YoutubeChannel.find(params[:id])
      result = YoutubeSyncService.new(@channel).sync!
      if result[:error]
        redirect_to admin_youtube_channels_path, alert: "Sync failed: #{result[:error]}"
      else
        redirect_to admin_youtube_channels_path, notice: "Synced #{@channel.name}: #{result[:created]} new, #{result[:updated]} updated."
      end
    end

    def destroy
      YoutubeChannel.find(params[:id]).destroy
      redirect_to admin_youtube_channels_path, notice: "Channel removed."
    end

    private

    def channel_params
      params.require(:youtube_channel).permit(:name, :channel_id, :api_key, :auto_sync)
    end
  end
end
