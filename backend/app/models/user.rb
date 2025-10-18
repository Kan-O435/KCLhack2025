# frozen_string_literal: true

class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User

  before_validation :generate_uid, on: :create

  def generate_uid
    self.uid = self.email if self.uid.blank? && self.email.present?
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
