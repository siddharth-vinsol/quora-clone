class ApplicationController < ActionController::Base
  before_action :authorize

  def authorize
    unless current_user
      redirect_to login_path, notice: t('notice.session.login_before_continue')
    end
  end

  private def current_user
    @user ||= User.find_by(id: cookies.encrypted[:user_id])
  end
end
