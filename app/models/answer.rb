class Answer < ApplicationRecord
  include VoteHandler
  include CommentsHandler

  after_create_commit :send_answer_posted_mail

  belongs_to :user
  belongs_to :question
  has_rich_text :content

  validates :content, presence: true

  private def send_answer_posted_mail
    if user_id != question.user_id
      UserMailer.answer_posted(id).deliver_later
    end
  end
end
