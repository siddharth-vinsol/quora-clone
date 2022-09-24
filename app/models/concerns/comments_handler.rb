module CommentsHandler
  def self.included(klass)
    klass.class_eval do
      has_many :comments, as: :commentable, dependent: :restrict_with_error
      has_many :sorted_comments, -> { by_most_upvoted.published_only.not_disabled }, as: :commentable, class_name: 'Comment'
    end
  end
end
