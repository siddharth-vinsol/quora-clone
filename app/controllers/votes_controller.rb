class VotesController < ApplicationController
  before_action :set_answer, only: [:upvote, :downvote]
  
  def upvote
    @answer.handle_vote(Vote.votes['upvote'], current_user.id)

    render json: { vote_count: @answer.votes.sum(:vote), type: 'upvote' }
  end

  def downvote
    @answer.handle_vote(Vote.votes['downvote'], current_user.id)
    render json: { vote_count: @answer.votes.sum(:vote), type: 'downvote' }
  end

  private def set_answer
    @answer = Answer.find(params[:answer_id])
  end
end
