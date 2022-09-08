class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_rich_text :content

  validates :content, presence: true
end
