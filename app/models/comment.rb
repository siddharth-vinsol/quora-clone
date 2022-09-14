class Comment < ApplicationRecord
  include VoteHandler
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_votes
  
  validates :content, presence: true
end
