class User < ApplicationRecord
  before_create :generate_confirmation_token
  after_create_commit :send_verification_mail

  enum role: {
    'admin' => 0,
    'user' => 1
  }

  has_secure_password

  validates :name, :email, :password, :password_confirmation, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: QuoraClone::EMAIL_REGEX }, allow_blank: true

  def update_password_reset_token
    update_columns(password_reset_token: TokenGenerator.generate_token)
  end

  def update_password(password, password_confirmation)
    update(password: password, password_confirmation: password_confirmation, password_reset_token: nil, password_reset_at: Time.now)
  end

  private def send_verification_mail
    UserMailer.verification(self).deliver_now
  end

  private def generate_confirmation_token
    self.confirmation_token = TokenGenerator.generate_token
  end
end
