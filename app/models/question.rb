class Question < ApplicationRecord
  belongs_to :user
  has_rich_text :content
  has_one_attached :attachment

  validates :title, :content, presence: true
  validates :total_upvotes, :total_downvotes, numericality: { greater_than_or_equal_to: 0 }
  validates :title, :permalink, uniqueness: true, allow_blank: true

  before_validation :assign_permalink, on: :create

  def publish
    update(published_at: Time.current)
  end

  def update_attachment(new_attachment)
    attachment.purge_later
    self.attachment = new_attachment
  end

  private def assign_permalink
    self.permalink = TokenHandler.generate_permalink
  end
end
