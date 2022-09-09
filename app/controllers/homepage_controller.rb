class HomepageController < ApplicationController
  skip_before_action :authorize

  def index
    @q = Question.where.not(published_at: nil).order('created_at DESC')
    if current_user
      @q = @q.where.not(user_id: current_user.id).ransack(params[:q])
    else
      @q = @q.ransack(params[:q])
    end

    @questions = @q.result.includes(:user)
  end
end
