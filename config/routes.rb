Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/home/about', to: 'homes#about', as: 'home_about' #aboutページルート
  root to: 'homes#top'
  get '/users/:id', to: 'users#show', as: 'user' #ログイン後のページルート(投稿一覧)
  get '/books', to: 'books#books', as: 'books' #全ての投稿一覧のページルート
  get '/users', to: 'users#index', as: 'users' #全ユーザのページルート
  resources :books
  resources :users, only: [:show, :edit, :update]
end
