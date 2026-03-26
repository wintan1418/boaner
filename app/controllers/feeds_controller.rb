class FeedsController < ApplicationController
  def index
    @posts = Post.published.limit(20)
    respond_to do |format|
      format.rss { render layout: false }
    end
  end
end
