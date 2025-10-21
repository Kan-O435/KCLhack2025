Rails.application.routes.draw do

  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for "User", at: "auth", controller: {
        registrations: "api/v1/registrations"
      }
      resources :articles

      resources :hair_models, only: [:create, :index]
    end
  end
end
