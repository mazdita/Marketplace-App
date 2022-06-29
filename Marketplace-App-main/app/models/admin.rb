class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def create_token
    @api_key = SecureRandom.urlsafe_base64
    update_columns(api_key: @api_key)
  end
end
