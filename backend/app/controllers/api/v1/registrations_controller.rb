module Api::V1
  class RegistrationsController < DeviseTokenAuth::RegistrationsController
    skip_after_action :update_auth_header, only: [:create]

    private

    def sign_up_params
      params.permit(:email, :password, :password_confirmation)
    end

    def account_update_params
      params.permit(:email, :password, :password_confirmation)
    end

    public

    def create
      user = User.new(sign_up_params)
      user.provider = 'email'
      user.uid = user.email

      if user.save
        token_headers = user.create_new_auth_token
        token_headers.each do |k, v|
          response.headers[k.to_s] = v.to_s
        end
        render json: { data: { id: user.id, email: user.email } }
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
end
