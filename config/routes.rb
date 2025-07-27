Rails.application.routes.draw do
  # Devise（ユーザー認証） - カスタムコントローラを指定
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # 投稿機能
  resources :posts do
    resource :like, only: [:create, :destroy]
  end

  # ユーザープロフィールページ
  resources :users, only: [:show]

  # ヘルスチェック
  get "up" => "rails/health#show", as: :rails_health_check

  # トップページ（投稿一覧へ）
  root to: "posts#index"
end