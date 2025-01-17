class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def index
    @comments = PostComment.all
  end

  def destroy
    @comment = PostComment.find(params[:id])
    @comment.destroy
    redirect_to admin_comments_path, notice: 'コメントを削除しました。'
  end
end
