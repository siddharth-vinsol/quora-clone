class Answer < ApplicationRecord
  include CommonScopes
  include VoteHandler
  include CommentsHandler
  include AbuseReportsHandler
  include AutoScrollHandler
  include NotificationsHandler

  after_create :generate_notifications
  after_create_commit :send_answer_posted_mail

  belongs_to :user
  belongs_to :question
  has_rich_text :content
  has_many :notifications, as: :notifiable
  
  validates :content, presence: true
  
  votes_has_credits

  private def send_answer_posted_mail
    if user_id != question.user_id
      UserMailer.answer_posted(id).deliver_later
    end
  end

  private def generate_notifications
    if user_id != question.user_id
      notifications.create(user: question.user, content: 'Someone posted an answer on your question.', redirect_link: question_path(question.permalink))
    end
  end
end
