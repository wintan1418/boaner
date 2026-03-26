module Videos
  class CommentsController < ApplicationController
    def create
      @video = Video.find(params[:video_id])
      @comment = @video.comments.build(comment_params)
      @comment.approved = false

      respond_to do |format|
        if @comment.save
          format.turbo_stream
          format.html { redirect_to @video, notice: "Comment submitted for review." }
        else
          format.html { redirect_to @video, alert: "Could not submit comment." }
        end
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:name, :body)
    end
  end
end
