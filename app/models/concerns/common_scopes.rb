module CommonScopes
  def self.included(klass)
    klass.class_eval do
      scope :by_recently_created, -> { order(created_at: :desc) }
      scope :published_only, -> { where.not(published_at: nil) }
    end
  end
end
