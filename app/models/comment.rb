class Comment < ApplicationRecord
  include CommonScopes
  include VoteHandler
  include AbuseReportsHandler

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  
  validates :content, presence: true
end
