module CommonScopes
  def self.included(klass)
    klass.class_eval do
      scope :by_recently_created, -> { order(created_at: :desc) }
    end
  end
end
