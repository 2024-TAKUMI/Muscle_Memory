module Public
  class GenresController < ApplicationController
    skip_before_action :authenticate_user!, only: [:index, :show, :subgenre]

    def index
      @parent_genres = Genre.where(parent_id: nil)
    end

    def show
      @genre = Genre.find(params[:id])
      @posts = @genre.posts
    end

    def subgenre
      @subgenre = Genre.find(params[:id])
      @posts = @subgenre.posts
    end
  end
end
