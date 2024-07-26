module Public
  class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show, :search]
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action :correct_user, only: [:edit, :update, :destroy]
    before_action :set_genres, only: [:new, :edit, :create, :update]

    def index
      @posts = current_user.posts
    end

    def show
      @post = Post.find(params[:id])
    end

    def new
      @post = Post.new
    end

    def create
      @post = current_user.posts.build(post_params)
      if @post.save
        flash[:notice] = "投稿が作成されました。"
        redirect_to @post
      else
        flash.now[:alert] = "投稿に失敗しました。"
        render :new
      end
    end

    def edit
    end

    def update
      if @post.update(post_params)
        if params[:post][:remove_image] == '1'
          @post.image.purge
        end
        flash[:notice] = "投稿が更新されました。"
        redirect_to @post
      else
        flash.now[:alert] = "更新に失敗しました。"
        render :edit
      end
    end

    def destroy
      @post.destroy
      flash[:notice] = "投稿が削除されました。"
      redirect_to posts_path
    end

    def search
      if params[:query].blank?
        flash[:alert] = "検索内容を入力してください。"
        redirect_to root_path
      else
        @query = params[:query]
        @posts = Post.where('title LIKE ? OR body LIKE ?', "%#{@query}%", "%#{@query}%")
        @genres = Genre.where('name LIKE ?', "%#{@query}%")
      end
    end

    private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body, :genre_id, :subgenre_id, :image, :remove_image)
    end

    def correct_user
      unless @post.user == current_user
        flash[:alert] = "他のユーザーの投稿は編集・削除できません。"
        redirect_to posts_path
      end
    end

    def set_genres
      @parent_genres = Genre.where(parent_id: nil)
      @subgenres = Genre.where.not(parent_id: nil)
    end

    def search_posts(query)
      terms = query.split('')
      posts = Post.all
      terms.each do |term|
        posts = posts.where('title LIKE ? OR body LIKE ?', "%#{term}%", "%#{term}%")
      end
      posts
    end

    def search_genres(query)
      terms = query.split('')
      genres = Genre.all
      terms.each do |term|
        genres = genres.where('name LIKE ?', "%#{term}%")
      end
      genres
    end
  end
end
