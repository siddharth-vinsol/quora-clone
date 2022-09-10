module VoteHandler
  def self.included(klass)
    klass.extend(ClassMethods)
  end

  module ClassMethods
    def has_votes
      has_many :votes, as: :voteable
    end
  end

  def handle_vote(vote_value, user_id)
    if @vote = votes.find_by(user_id: user_id)
      if @vote.vote == vote_value
        @vote.destroy
      else
        @vote.update(vote: vote_value)
      end
    else
      votes.create(vote: vote_value, user_id: user_id)
    end
  end
end
