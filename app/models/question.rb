class Question < ApplicationRecord
  belongs_to :user
  has_rich_text :content
  
  before_validation :assign_default_values, on: :create

  validates :title, :content, :permalink, presence: true
  validates :total_upvotes, :total_downvotes, numericality: { greater_than_or_equal_to: 0 }
  validates :title, :permalink, uniqueness: true

  private def assign_default_values
    self.total_downvotes = 0
    self.total_upvotes = 0
    self.permalink = TokenGenerator.generate_permalink
  end
end
