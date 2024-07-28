Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations'
  }
  devise_for :admins, controllers: {
    sessions: 'admin/sessions'
  }

  # ユーザー側
  root to: 'public/homes#top'
  get '/about', to: 'public/homes#about'

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
    
    # グループのルーティング
    resources :groups do
      member do
        post 'join'
        post 'leave'
      end
      resources :messages, only: [:create]
    end
  end
  
  # ジャンル用のルート
  get 'upper_body', to: 'public/posts#upper_body'
  get 'lower_body', to: 'public/posts#lower_body'

  # 管理者側
  namespace :admin do
    root to: 'homes#top'
    resources :users, only: [:index, :show, :destroy] do
      resources :comments, only: [:destroy], module: :users
    end
    resources :genres, only: [:index, :create, :destroy]
    resources :posts, only: [:destroy]
    resources :comments, only: [:index, :destroy]
    
    # 管理者用グループ管理のルーティング
    resources :groups, only: [:index, :destroy]
  end

  # メールアドレスとパスワードの変更用ルーティング
  devise_scope :user do
    get 'users/edit_email_password', to: 'public/registrations#edit_email_password', as: 'edit_email_password'
    patch 'users/update_email_password', to: 'public/registrations#update_email_password', as: 'update_email_password'
  end
end
