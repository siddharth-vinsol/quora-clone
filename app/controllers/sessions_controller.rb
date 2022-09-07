class SessionsController < ApplicationController
  skip_before_action :authorize

  before_action :set_user, only: [:create]
  before_action :authenticate_user, only: [:create]
  
  def login
  end

  def create
    if @user.is_verified?
      handle_logged_in_user
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

  private def handle_logged_in_user
    case
    when @user.disabled_at?
      redirect_to login_url, notice: t('notice.session.disabled_account.')
    when @user.admin?
      create_auth_cookie
      redirect_to admin_path
    when @user.verified_at?
      create_auth_cookie
      redirect_to user_path
    else
      redirect_to login_url, notice: t('notice.session.verify_before_continue')
    end
  end

  private def create_auth_cookie
    cookies.encrypted[:user_id] = { 
      value: @user.id,
      expires: cookie_expiration_time
    }
  end

  private def cookie_expiration_time
    params[:remember_me] == '1' ? QuoraClone::Session::COOKIE_EXPIRATION_TIME.from_now : nil
  end
end
