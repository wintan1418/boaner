class PostsController < ApplicationController
  def index
    @posts = Post.published.by_category(params[:category])
    @categories = Post.distinct.pluck(:category).compact

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
    @post = Post.find_by!(slug: params[:id])
    @comments = @post.comments.approved.order(created_at: :desc)
    @comment = Comment.new
  end
end
