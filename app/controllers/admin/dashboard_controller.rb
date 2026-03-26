module Admin
  class DashboardController < BaseController
    def index
      @video_count = Video.count
      @post_count = Post.count
      @course_count = Course.count
      @subscriber_count = Subscriber.count
      @pending_comments_count = Comment.pending.count
      @book_count = Book.count

      @recent_videos = Video.order(created_at: :desc).limit(5)
      @recent_posts = Post.order(created_at: :desc).limit(5)
      @recent_comments = Comment.order(created_at: :desc).limit(5)
      @recent_subscribers = Subscriber.order(created_at: :desc).limit(5)
    end
  end
end
