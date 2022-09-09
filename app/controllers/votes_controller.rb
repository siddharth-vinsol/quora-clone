class VotesController < ApplicationController
  before_action :set_answer, only: [:upvote, :downvote]
  
  def upvote
    @answer.handle_vote(Vote.votes['upvote'], current_user.id)
    redirect_to request.referrer
  end

  def downvote
    @answer.handle_vote(Vote.votes['downvote'], current_user.id)
    redirect_to request.referrer
  end

  private def set_answer
    @answer = Answer.find(params[:answer_id])
  end
end
