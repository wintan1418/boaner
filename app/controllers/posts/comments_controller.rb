module Posts
  class CommentsController < ApplicationController
    def create
      @post = Post.find_by!(slug: params[:post_id])
      @comment = @post.comments.build(comment_params)
      @comment.approved = false

      respond_to do |format|
        if @comment.save
          format.turbo_stream
          format.html { redirect_to @post, notice: "Comment submitted for review." }
        else
          format.html { redirect_to @post, alert: "Could not submit comment." }
        end
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:name, :body)
    end
  end
end
