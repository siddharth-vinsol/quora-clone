class Question < ApplicationRecord
  include CommonScopes
  
  attr_accessor :should_publish

  belongs_to :user
  has_many :answers, dependent: :restrict_with_error
  has_many :sorted_answers, -> { order(Arel.sql('total_upvotes - total_downvotes DESC')) }, class_name: 'Answer', dependent: :restrict_with_error
  has_rich_text :content
  has_one_attached :attachment

  validates :title, :content, presence: true
  validates :total_upvotes, :total_downvotes, numericality: { greater_than_or_equal_to: 0 }
  validates :title, :permalink, uniqueness: true, allow_blank: true

  before_validation :assign_permalink, on: :create
  before_save :publish_question, if: :should_publish, unless: :published_at?

  scope :published_questions, -> { where.not(published_at: nil) }
  scope :of_user, -> (user) { where(user: user) }

  def publish
    update(should_publish: true)
  end

  def file_attached?
    attachment.present?
  end
  
  def editable?
    answers.blank?
  end

  private def assign_permalink
    self.permalink = TokenHandler.generate_permalink
  end

  private def publish_question
    self.published_at = Time.current
  end
end
