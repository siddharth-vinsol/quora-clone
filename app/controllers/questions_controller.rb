class QuestionsController < ApplicationController
  before_action :set_question, only: [:show]

  def index
    @questions = Question.where.not(published_at: nil).where.not(user_id: current_user.id).order('created_at DESC').includes(:user)
    @questions = @questions.where('title LIKE ?', '%' + Question.sanitize_sql_like(params[:search_title]) + '%') unless params[:search_title].empty?
  end

  def show
  end

  private def set_question
    @question = Question.find(params[:id])
  end
end
