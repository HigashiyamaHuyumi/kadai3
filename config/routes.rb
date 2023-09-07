Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get '/users/:id', to: 'users#show', as: 'user' #ログイン後のページルート
  #get '/users/:id/edit', to: 'users#edit', as: 'edit_user' # ユーザー情報の編集ページルート
  #patch '/users/:id', to: 'users#update'  # ユーザー情報の更新処理のルート
  resources :users, only: [:show, :edit, :update] do
    resources :books
  end
end
