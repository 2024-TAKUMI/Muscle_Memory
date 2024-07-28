module Public
  class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show, :search, :upper_body, :lower_body]
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action :correct_user, only: [:edit, :update, :destroy]
    before_action :set_genres, only: [:new, :edit, :create, :update]

    def index
      if params[:query].present?
        @search_query = params[:query]
        session[:search_query] = @search_query
        @posts = Post.where('title LIKE ? OR body LIKE ?', "%#{@search_query}%", "%#{@search_query}%")
      else
        session.delete(:search_query)
        @posts = Post.all
      end
    end

    def show
      @search_query = session[:search_query]
      session[:return_to] = request.referer if request.referer
      @post.increment!(:views_count)  # 閲覧数をカウントアップ
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
        flash[:alert] = "検索する内容を入力してください。"
        redirect_back(fallback_location: root_path)
      else
        @search_query = params[:query]
        session[:search_query] = @search_query
        @posts = Post.where('title LIKE ? OR body LIKE ?', "%#{@search_query}%", "%#{@search_query}%")
        render :index
      end
    end

    def upper_body
      @posts = Post.where(genre_id: Genre.where(name: ['肩', '胸', '背中', 'お腹', '腕']).pluck(:id))
    end

    def lower_body
      @posts = Post.where(genre_id: Genre.where(name: ['太もも', 'ふくらはぎ', 'お尻']).pluck(:id))
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
  end
end
