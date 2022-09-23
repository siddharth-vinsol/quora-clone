class HomepageController < ApplicationController
  skip_before_action :authorize

  before_action :update_search_params, only: [:index], if: :signed_in?

  def index
    @q = Question.includes(:user, :rich_text_content).published_only.by_recently_created.ransack(params[:q])
    @questions = @q.result
  end

  private def update_search_params
    if params[:q].present?
      params[:q][:user_id_not_eq] = current_user.id
    else
      params[:q] = { user_id_not_eq: current_user.id }
    end
  end
end
