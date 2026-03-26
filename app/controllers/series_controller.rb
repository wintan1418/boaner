class SeriesController < ApplicationController
  def index
    @series = Series.order(:position, :title)
  end

  def show
    @series_record = Series.find_by!(slug: params[:id])
    @videos = @series_record.videos
  end
end
