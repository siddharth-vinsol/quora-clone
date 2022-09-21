class HomepageController < ApplicationController
  skip_before_action :authorize

  before_action :discard_current_user_questions, only: [:index], if: :signed_in?

  def index
    @q = Question.includes(:user, :rich_text_content).published_questions.by_recently_created.ransack(params[:q])
    @questions = @q.result
  end

  private def discard_current_user_questions
    if params[:q].present?
      params[:q][:user_id_not_eq] = current_user.id
    else
      params[:q] = { user_id_not_eq: current_user.id }
    end
  end
end
