class Answer < ApplicationRecord
  include VoteHandler

  belongs_to :user
  belongs_to :question
  has_rich_text :content
  has_votes

  validates :content, presence: true
end
