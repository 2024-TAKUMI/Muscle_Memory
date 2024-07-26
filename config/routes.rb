Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations'
  }
  devise_for :admin, controllers: {
    sessions: 'admin/sessions'
  }

  # ユーザー
  root to: 'public/homes#top'
  get '/about', to: 'public/homes#about'

  # 投稿関連
  scope module: :public do
    resources :posts do
      resources :post_comments, only: [:create, :destroy]
      collection do
        get 'search'
      end
    end
    resources :genres, only: [:index, :show] do
      member do
        get 'subgenre', to: 'genres#subgenre'
      end
    end
    resources :users, only: [:show, :edit, :update, :destroy]
  end

  # 管理者
  namespace :admin do
    get '/', to: 'homes#top', as: :root
  end

  # メールアドレスとパスワードの変更用ルーティングを追加
  devise_scope :user do
    get 'users/edit_email_password', to: 'public/registrations#edit_email_password', as: 'edit_email_password'
    patch 'users/update_email_password', to: 'public/registrations#update_email_password', as: 'update_email_password'
  end
end
