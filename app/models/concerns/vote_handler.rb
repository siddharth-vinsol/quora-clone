module VoteHandler
  def self.included(klass)
    klass.class_eval do
      cattr_accessor :creditable, instance_reader: true
      
      has_many :votes, as: :voteable, dependent: :destroy
      scope :by_most_upvoted, -> { order(Arel.sql('total_upvotes - total_downvotes DESC')) }
      
      def self.votes_has_credits
        self.creditable = true
      end
    end
  end

  def upvote(user_id)
    handle_vote('upvote', user_id)
  end

  def downvote(user_id)
    handle_vote('downvote', user_id)
  end

  def handle_vote(vote_value, user_id)
    if @vote = votes.find_by(user_id: user_id)
      if @vote.vote == vote_value
        @vote.destroy
        handle_total_votes(vote_value, :destroy)
      else
        @vote.update(vote: vote_value)
        handle_total_votes(vote_value, :update)
      end
    else
      votes.create(vote: vote_value, user_id: user_id)
      handle_total_votes(vote_value, :create)
    end
    
    handle_resource_credits
  end

  def handle_total_votes(vote_value, context)
    if vote_value == 'upvote'
      case context
      when :create
        increment!(:total_upvotes)
      when :update
        increment!(:total_upvotes)
        decrement!(:total_downvotes)
      when :destroy
        decrement!(:total_upvotes)
      end
    else
      case context
      when :create
        increment!(:total_downvotes)
      when :update
        increment!(:total_downvotes)
        decrement!(:total_upvotes)
      when :destroy
        decrement!(:total_downvotes)
      end
    end
  end

  def handle_resource_credits
    return unless creditable

    if net_votes >= QuoraClone::Credits::MINIMUM_VOTES_TO_REWARD_CREDITS
      unless user.credit_transactions.where(entity: self).last.try(:credit?)
        user.update_credits(1, self, 'Answer Reward')
      end
    else
      if user.credit_transactions.where(entity: self).last.try(:credit?)
        user.update_credits(-1, self, 'Answer Penalty')
      end
    end
  end

  def net_votes
    total_upvotes - total_downvotes
  end
end
