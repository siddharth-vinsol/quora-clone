class SessionsController < ApplicationController
  skip_before_action :authorize
  
  def login
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      if @user.verified_at?
        cookies.encrypted[:login] = { value: @user.id, expires: QuoraClone::Session::COOKIE_EXPIRATION_TIME.from_now } if params[:remember_me] == '1'
        session[:user_id] = @user.id
        redirect_to user_path
      else
        redirect_to login_url, notice: 'Please verify your account using link sent on your email before moving further'
      end
    else
      redirect_to login_url, notice: 'Wrong email and password combination. Please try again'
    end
  end

  def destroy
    reset_session
    cookies.delete(:login)
    redirect_to login_path, notice: 'Logged out successfully'
  end
end
