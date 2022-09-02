class SessionsController < ApplicationController
  skip_before_action :authorize
  
  def login
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      if @user.verified_at?
        cookies.encrypted[:user_id] = { 
          value: @user.id,
          expires: params[:remember_me] == '1' ? QuoraClone::Session::COOKIE_EXPIRATION_TIME.from_now : nil
        }
        redirect_to user_path
      else
        redirect_to login_url, notice: t('notice.session.verify_before_continue')
      end
    else
      redirect_to login_url, notice: t('notice.session.invalid_email_password')
    end
  end

  def destroy
    cookies.delete(:user_id)
    redirect_to login_path, notice: t('notice.session.logout_success')
  end
end
