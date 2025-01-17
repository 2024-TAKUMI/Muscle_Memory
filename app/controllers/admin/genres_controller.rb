class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def index
    @genres = Genre.all
    @new_genre = Genre.new
  end

  def create
    @new_genre = Genre.new(genre_params)
    if @new_genre.save
      redirect_to admin_genres_path, notice: 'ジャンルを追加しました。'
    else
      @genres = Genre.all
      render :index
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    if @genre.subgenres.any? || @genre.posts.any?
      redirect_to admin_genres_path, alert: '記事が紐付けられています'
    else
      @genre.destroy
      redirect_to admin_genres_path, notice: 'ジャンルを削除しました。'
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
