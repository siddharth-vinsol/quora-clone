class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :votes, as: :voteable
  has_rich_text :content

  validates :content, presence: true

  def handle_vote(vote_value, user_id)
    if @vote = votes.find_by(user_id: user_id)
      if Vote.votes[@vote.vote] == vote_value
        @vote.destroy
      else
        @vote.update(vote: vote_value)
      end
    else
      votes.create(vote: vote_value, user_id: user_id)
    end
  end
end
