class Comment < ApplicationRecord
  include CommonScopes
  include VoteHandler
  include AbuseReportsHandler
  include AutoScrollHandler
  include NotificationsHandler

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :notifications, as: :notifiable, dependent: :destroy
  
  validates :content, presence: true

  after_create :generate_notifications

  def redirect_link
    if commentable_type == 'Question'
      question_path(commentable.permalink, scroll_to: scrollable_id)
    else
      question_path(commentable.question.permalink, scroll_to: scrollable_id)
    end
  end

  private def generate_notifications
    if user_id != commentable.user_id
      if commentable_type == 'Question'
        content = 'Someone commented on your question.'
      else
        content = 'Someone commented on your answer.'
      end

      notifications.create(user: commentable.user, content: content)
    end
  end
end
