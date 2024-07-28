class Public::HomesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:top, :about]

  def top
    @recommended_posts = Post.order(views_count: :desc, comments_count: :desc).limit(5)
    @recommended_users = User.joins(:posts)
                             .group('users.id')
                             .order('SUM(posts.views_count) DESC', 'SUM(posts.comments_count) DESC')
                             .limit(5)
    @latest_posts = Post.order(created_at: :desc).limit(10)
  end

  def about
  end
end
