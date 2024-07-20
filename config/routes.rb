Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  
  devise_for :admin, controllers: {
    sessions: 'admin/sessions'
  }
  
  # ユーザー側
  root to: 'public/homes#top'
  get '/about', to: 'public/homes#about'

  # 管理者側
  namespace :admin do
    get '/', to: 'homes#top', as: :root
  end

  # ユーザーのマイページへのルートを定義
  resources :users, only: [:show]
end
