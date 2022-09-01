class ApplicationController < ActionController::Base
  before_action :authorize
  
  def authorize
    unless @user = User.find_by(id: session[:user_id])
      redirect_to login_path, notice: 'Please log in before continuing'
    end
  end
end
