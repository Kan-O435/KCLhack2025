class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # サインアップ時に email / password / password_confirmation を許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation])
    # サインイン時に email / password を許可
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end
end
