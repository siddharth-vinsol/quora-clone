class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :votes, as: :voteable
  has_rich_text :content

  validates :content, presence: true
end
