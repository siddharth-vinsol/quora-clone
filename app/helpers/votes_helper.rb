module VotesHelper
  def vote_classes_for_current_user(answer, vote_type)
    default_class = 'vote-button '
    if answer.votes.find_by(user_id: @user.id, vote: vote_type)
      default_class << vote_type
    end
    default_class
  end

  def net_vote_count(answer)
    answer.votes.sum(:vote)
  end
end
