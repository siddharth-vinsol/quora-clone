class HomepageController < ApplicationController
  skip_before_action :authorize

  before_action :update_search_params, only: [:index], if: :signed_in?

  def index
    @q = Question.includes(:user, :rich_text_content).published_only.not_disabled.by_recently_created.ransack(search_params)
    @questions = @q.result
  end

  private def update_search_params
    if params[:q].present?
      params[:q][:user_id_not_eq] = current_user.id
    else
      params[:q] = { user_id_not_eq: current_user.id }
    end
  end
  
  private def search_params
    if params[:q].present?
      ransack_params = params.require(:q).permit(:title_cont, :user_id_not_eq, :user_id_eq_any, topics_name_eq_any: [])
      ransack_params[:user_id_eq_any] = ransack_params[:user_id_eq_any].try(:split)
      ransack_params
    end
  end
end
