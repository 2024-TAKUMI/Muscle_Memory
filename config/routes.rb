Rails.application.routes.draw do
  # Devise routes for users and admins
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  devise_for :admin, controllers: {
    sessions: 'admin/sessions'
  }

  # Public
  root to: 'public/homes#top'
  get '/about', to: 'public/homes#about'

  # Posts
  scope module: :public do
    resources :posts do
      collection do
        get 'subgenres', to: 'posts#subgenres'
      end
    end
    resources :genres, only: [:index, :show] do
      member do
        get 'subgenre', to: 'genres#subgenre'
      end
    end
    resources :users, only: [:show]
  end

  # Admin routes
  namespace :admin do
    get '/', to: 'homes#top', as: :root
  end
end