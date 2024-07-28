class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to request.referer, notice: '投稿を削除しました。'
  end
end
