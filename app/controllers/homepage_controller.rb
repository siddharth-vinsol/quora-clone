class HomepageController < ApplicationController
  skip_before_action :authorize

  def index
    if current_user
      @questions = Question.where.not(published_at: nil).where.not(user_id: current_user.id).order('created_at DESC').includes(:user)
    else
      @questions = Question.where.not(published_at: nil).order('created_at DESC').includes(:user)
    end
  end
end
