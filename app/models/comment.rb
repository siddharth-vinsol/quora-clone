class Comment < ApplicationRecord
  include CommonScopes
  include VoteHandler
  include AbuseReportsHandler
  include AutoScrollHandler
  include NotificationsHandler

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :notifications, as: :notifiable
  
  validates :content, presence: true

  after_create :generate_notifications

  private def generate_notifications
    if user_id != commentable.user_id
      if commentable_type == 'Question'
        content = 'Someone commented on your question.'
        redirect_link = question_path(commentable.permalink, scroll_to: "comment-#{id}")
      else
        content = 'Someone commented on your answer.'
        redirect_link = question_path(commentable.question.permalink, scroll_to: "comment-#{id}")
      end

      notifications.create(user: commentable.user, content: content, redirect_link: redirect_link)
    end
  end
end
