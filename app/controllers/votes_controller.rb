class VotesController < ApplicationController
  before_action :set_voteable, only: [:upvote, :downvote]
  
  def upvote
    @voteable.upvote(current_user.id)
    render json: { vote_count: @voteable.total_upvotes - @voteable.total_downvotes, type: 'upvote' }
  end

  def downvote
    @voteable.downvote(current_user.id)
    render json: { vote_count: @voteable.total_upvotes - @voteable.total_downvotes, type: 'downvote' }
  end

  private def set_voteable
    @voteable = params[:voteable_type].constantize.find(params[:voteable_id])
  end
end
