class VotesController < ApplicationController
  before_action :set_voteable, only: [:upvote, :downvote]
  
  def upvote
    @voteable.handle_vote('upvote', current_user.id)
    render json: { vote_count: @voteable.votes.sum(:vote), type: 'upvote' }
  end

  def downvote
    @voteable.handle_vote('downvote', current_user.id)
    render json: { vote_count: @voteable.votes.sum(:vote), type: 'downvote' }
  end

  private def set_voteable
    @voteable = params[:voteable_type].constantize.find(params[:voteable_id])
  end
end
