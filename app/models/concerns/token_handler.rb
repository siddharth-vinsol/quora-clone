module TokenHandler
  class << self
    def generate_token(n = 32)
      SecureRandom.base58(n)
    end
  
    def token_expired?(token_generated_time, duration)
      Time.current - token_generated_time.to_time > duration
    end
  end

  def self.generate_permalink
    SecureRandom.uuid
  end
end
