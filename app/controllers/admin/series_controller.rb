module Admin
  class SeriesController < BaseController
    before_action :set_series, only: [ :show, :edit, :update, :destroy ]

    def index
      @series = Series.order(:position, :title)
    end

    def show
      redirect_to edit_admin_series_path(@series)
    end

    def new
      @series = Series.new
    end

    def create
      @series = Series.new(series_params)
      if @series.save
        redirect_to admin_series_index_path, notice: "Series created successfully."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @series.update(series_params)
        redirect_to admin_series_index_path, notice: "Series updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @series.destroy
      redirect_to admin_series_index_path, notice: "Series deleted."
    end

    private

    def set_series
      @series = Series.find(params[:id])
    end

    def series_params
      params.require(:series).permit(:title, :slug, :description, :position)
    end
  end
end
