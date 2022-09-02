module TokenGenerator
  def self.generate_token(n = 32)
    SecureRandom.base58(n)
  end
end
