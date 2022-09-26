class ApplicationController < ActionController::Base
  before_action :authorize

  private def authorize
    unless signed_in?
      redirect_to login_path, notice: t('login_before_continue')
    end
  end

  private def signed_in?
    current_user.present?
  end

  private def current_user
    @user ||= User.find_by(id: cookies.encrypted[:user_id])
  end

  helper_method :current_user, :signed_in?
end
