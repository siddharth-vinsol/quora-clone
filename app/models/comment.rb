class Comment < ApplicationRecord
  include CommonScopes
  include VoteHandler
  include AbuseReportsHandler
  include AutoScrollHandler

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  
  validates :content, presence: true
end
