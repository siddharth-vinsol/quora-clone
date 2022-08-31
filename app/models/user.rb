class User < ApplicationRecord
  after_create_commit :send_verification_mail

  enum role: {
    'admin' => 0,
    'user' => 1
  }

  has_secure_password

  validates :name, :email, :password, :password_confirmation, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: QuoraClone::EMAIL_REGEX }, allow_blank: true

  private def send_verification_mail
    UserMailer.verification(self).deliver_now
  end
end
