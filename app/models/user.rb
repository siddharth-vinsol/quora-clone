class User < ApplicationRecord
  VALID_IMAGE_MIME_TYPES = ['image/png', 'image/jpeg']
  acts_as_taggable_on :topics

  before_create :generate_confirmation_token
  after_create_commit :send_verification_mail

  enum role: {
    'admin' => 0,
    'user' => 1
  }

  has_secure_password
  has_one_attached :profile_image, dependent: :destroy
  has_many :questions, dependent: :restrict_with_error
  has_many :credit_transactions, dependent: :destroy

  validates :name, :email, presence: true
  validates :password, :password_confirmation, presence: true, if: :setting_password?
  validates :email, uniqueness: true
  validates :email, format: { with: QuoraClone::RegexConstants::EMAIL_REGEX }, allow_blank: true
  validates :profile_image, attached_file_type: { types: VALID_IMAGE_MIME_TYPES }, allow_blank: true
  validates :credits, numericality: true

  def update_password_reset_token
    if update(password_reset_token: TokenHandler.generate_token, reset_password_sent_at: Time.current)
      send_password_reset_mail
    end
  end

  def clear_password_reset_token
    update(password_reset_token: nil)
  end

  def verify
    update(confirmation_token: nil, verified_at: Time.current) && update_credits(QuoraClone::Credits::SUCCESS_VERIFICATION_CREDITS, 'Verfication Reward.')
  end

  def update_credits(amount, entity, reason)
    self.credits = self.credits + amount

    transaction_type = 'credit'
    if amount < 0
      transaction_type = 'debit'
      amount *= -1
    end
    credit_transactions.build({ value: amount, entity: entity, reason: reason, transaction_type: transaction_type })

    save
  end

  def password_reset_token_expired?
    TokenHandler.token_expired?(reset_password_sent_at, QuoraClone::Token::TOKEN_EXPIRATION_TIME)
  end

  def is_verified?
    verified_at.present?
  end

  private def send_verification_mail
    UserMailer.verification(self).deliver_later
  end

  private def send_password_reset_mail
    UserMailer.reset_password(self).deliver_later
  end

  private def generate_confirmation_token
    self.confirmation_token = TokenHandler.generate_token
  end

  private def setting_password?
    password || password_confirmation
  end
end
