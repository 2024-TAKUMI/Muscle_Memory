class PostCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @post_comment = @post.post_comments.new(post_comment_params)
    @post_comment.user = current_user
    if @post_comment.save
      redirect_to @post, notice: 'コメントが投稿されました。'
    else
      redirect_to @post, alert: 'コメントの投稿に失敗しました。'
    end
  end

  def destroy
    @post_comment = @post.post_comments.find(params[:id])
    if @post_comment.user == current_user || current_user.admin?
      @post_comment.destroy
      redirect_to @post, notice: 'コメントが削除されました。'
    else
      redirect_to @post, alert: 'コメントの削除に失敗しました。'
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def post_comment_params
    params.require(:post_comment).permit(:content, :image)
  end
end
