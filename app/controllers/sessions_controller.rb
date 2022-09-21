class SessionsController < ApplicationController
  skip_before_action :authorize

  before_action :set_user, only: [:create]
  before_action :authenticate_user, only: [:create]
  
  def login
  end

  def create
    if @user.is_verified?
      cookies.encrypted[:user_id] = { 
        value: @user.id,
        expires: cookie_expiration_time
      }
      redirect_to user_path
    else
      redirect_to login_url, notice: t('verify_before_continue')
    end
  end

  def destroy
    cookies.delete(:user_id)
    redirect_to login_path, notice: t('logout_success')
  end

  private def set_user
    unless @user = User.find_by(email: params[:email])
      redirect_to login_url, notice: t('invalid_email_password')
    end
  end

  private def authenticate_user
    unless @user.authenticate(params[:password])
      redirect_to login_url, notice: t('invalid_email_password')
    end
  end

  private def cookie_expiration_time
    params[:remember_me] == '1' ? QuoraClone::Session::COOKIE_EXPIRATION_TIME.from_now : nil
  end
end
