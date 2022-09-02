class ApplicationController < ActionController::Base
  before_action :authorize

  def authorize
    unless set_current_user
      redirect_to login_path, notice: 'Please log in before continuing'
    end
  end

  private def set_current_user
    @user = User.find_by(id: cookies.encrypted[:user_id])
  end
end
