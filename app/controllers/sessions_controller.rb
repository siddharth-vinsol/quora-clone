class SessionsController < ApplicationController
  def login
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_path, notice: "Welcome #{@user.name}"
    else
      render :login, notice: 'Wrong email and password combination. Please try again'
    end
  end
end
