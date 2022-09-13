module TokenHandler
  def self.generate_token(n = 32)
    SecureRandom.base58(n)
  end

  def self.token_expired?(token_generated_time)
    Time.current - token_generated_time.to_time > QuoraClone::Token::TOKEN_EXPIRATION_TIME
  end
end
