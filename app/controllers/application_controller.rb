class ApplicationController < ActionController::Base
  before_action :authorize

  def authorize
    unless current_user
      redirect_to login_path, notice: 'Please log in before continuing'
    end
  end

  private def current_user
    @user ||= User.find_by(id: cookies.encrypted[:user_id])
  end

  private def current_user_by_email
    @user = User.find_by(email: params[:email])
  end
end
