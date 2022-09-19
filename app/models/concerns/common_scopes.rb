module CommonScopes
  def self.included(klass)
    klass.class_eval do
      scope :chronological_order, -> { order(created_at: :desc) }
    end
  end
end
