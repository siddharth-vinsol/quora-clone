class Vote < ApplicationRecord
  belongs_to :voteable, polymorphic: true

  enum value: {
    'upvote' => 1,
    'downvote' => -1
  }

  validates :vote, presence: true
end
