class Question < ApplicationRecord
  include CommonScopes
  include VoteHandler
  include CommentsHandler
  include AbuseReportsHandler
  include AutoScrollHandler
  include NotificationsHandler
  
  attr_accessor :should_publish

  acts_as_taggable_on :topics
  
  belongs_to :user
  has_many :answers, dependent: :restrict_with_error
  has_many :sorted_answers, -> { by_most_upvoted.published_only.not_disabled }, class_name: 'Answer'
  has_many :abuse_reports, as: :abuse_reportable
  has_rich_text :content
  has_one_attached :attachment
  has_many :notifications, as: :notifiable

  validates :title, :content, presence: true
  validates :total_upvotes, :total_downvotes, numericality: { greater_than_or_equal_to: 0 }
  validates :title, :permalink, uniqueness: true, allow_blank: true
  validates :published_at, minimum_credits: true, if: :published_at?

  before_validation :assign_permalink, on: :create
  before_validation :publish_question, if: :should_publish, unless: :published_at?
  after_save :generate_notifications, if: [:should_publish, :published_at?]

  scope :of_user, -> (user) { where(user: user) }

  def publish
    update(should_publish: true)
  end

  def file_attached?
    attachment.present?
  end

  def editable?
    answers.blank? && votes.blank? && comments.blank? && abuse_reports.blank?
  end

  def redirect_link
    question_path(permalink, scroll_to: scrollable_id)
  end

  private def assign_permalink
    self.permalink = TokenHandler.generate_permalink
  end

  private def publish_question
    self.published_at = Time.current
  end

  private def generate_notifications
    handle_topic_notifications
  end

  private def handle_topic_notifications
    users = User.tagged_with(topic_list, any: true)
    users.each do |user|
      notifications.create(user: user, content: 'Question posted related to your interest') if self.user.id != user.id
    end
  end
end
