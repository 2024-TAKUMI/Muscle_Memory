Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  devise_for :admin, controllers: {
    sessions: 'admin/sessions'
  }

  # ユーザー
  root to: 'public/homes#top'
  get '/about', to: 'public/homes#about'

  # 投稿関連
  scope module: :public do
    resources :posts
    resources :genres, only: [:index, :show] do
      member do
        get 'subgenre', to: 'genres#subgenre'
      end
    end
    resources :users, only: [:show, :edit, :update, :destroy]
    get 'search', to: 'posts#search', as: :search_posts
  end

  # 管理者
  namespace :admin do
    get '/', to: 'homes#top', as: :root
  end
end
