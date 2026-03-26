module Admin
  class CommentsController < BaseController
    before_action :set_comment, only: [ :update, :destroy ]

    def index
      @comments = Comment.includes(:commentable).order(created_at: :desc)
    end

    def update
      @comment.update(approved: !@comment.approved)
      redirect_to admin_comments_path, notice: "Comment #{@comment.approved? ? 'approved' : 'unapproved'}."
    end

    def destroy
      @comment.destroy
      redirect_to admin_comments_path, notice: "Comment deleted."
    end

    private

    def set_comment
      @comment = Comment.find(params[:id])
    end
  end
end
