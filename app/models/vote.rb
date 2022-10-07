class Vote < ApplicationRecord
  enum vote: {
    'upvote' => 1,
    'downvote' => -1
  }
  
  belongs_to :voteable, polymorphic: true
  
  validates :vote, presence: true
end
