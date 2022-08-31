class User < ApplicationRecord
  enum role: {
    'admin' => 0,
    'user' => 1
  }

  has_secure_password

  validates :name, :email, :password, :password_confirmation, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: QuoraClone::EMAIL_REGEX }, allow_blank: true

end
