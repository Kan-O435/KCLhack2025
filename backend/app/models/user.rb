class User < ActiveRecord::Base
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # DeviseTokenAuth
  include DeviseTokenAuth::Concerns::User
end
