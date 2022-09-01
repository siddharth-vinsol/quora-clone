class ApplicationController < ActionController::Base
  before_action :auto_login
  before_action :authorize

  def authorize
    unless @user = User.find_by(id: session[:user_id])
      redirect_to login_path, notice: 'Please log in before continuing'
    end
  end

  private def auto_login
    if !session[:user_id] && cookies.encrypted[:login]
      session[:user_id] = cookies.encrypted[:login]
      redirect_to user_path
    end
  end
end
