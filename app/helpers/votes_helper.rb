module VotesHelper
  def vote_classes_for_current_user(voteable, vote_type)
    default_class = 'vote-button '
    if voteable.votes.find_by(user_id: @user.id, vote: vote_type)
      default_class << vote_type
    end
    default_class
  end

  def net_vote_count(voteable)
    voteable.votes.sum(:vote)
  end
end
