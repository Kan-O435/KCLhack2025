Rails.application.routes.draw do
  # ヘルスチェック用エンドポイント
  get "up", to: "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      # DeviseTokenAuth のユーザー認証ルート（カスタム登録・セッションコントローラ）
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/registrations',
        sessions: 'api/v1/sessions'
      }

      # 記事の CRUD
      resources :articles

      # HairModel の作成・一覧と成長計算用のカスタムアクション
      resources :hair_models, only: [:create, :index] do
        collection do
          get :calculate_growth
        end
      end

      # ユーザー情報の更新
      resource :user, only: [:update]

      # 予約関連の一覧・作成
      resources :appointments, only: [:index, :create]
    end
  end
end
