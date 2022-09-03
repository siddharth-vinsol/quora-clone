class PasswordsController < ApplicationController
  skip_before_action :authorize, except: [:change, :change_password]

  before_action :set_user, only: [:reset, :update_password]
  before_action :check_token_expiry, only: [:reset, :update_password]

  def show
  end

  def generate_reset_token
    if current_user_by_email && @user.update_password_reset_token
      redirect_to password_path, notice: t('reset_mail_sent')
    else
      redirect_to password_path, notice: t('email_not_found')
    end
  end

  def reset
  end

  def update_password
    if @user.update(reset_password_params)
      @user.clear_password_reset_token
      redirect_to login_path, notice: t('reset_success')
    else
      render :reset, status: :unprocessable_entity
    end
  end

  def change_password
    if @user.update_password(reset_password_params[:password], reset_password_params[:password_confirmation])
      redirect_to user_profile_path, notice: t('notice.password.change_success')
    else
      render :change, status: :unprocessable_entity
    end
  end

  private def reset_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  private def set_user
    unless params[:token].present? && @user = User.find_by(password_reset_token: params[:token])
      redirect_to password_path, notice: t('invalid_reset_request')
    end
  end

  private def current_user_by_email
    @user = User.find_by(email: params[:email])
  end

  private def check_token_expiry
    redirect_to password_path, notice: t('token_expired') if @user.password_reset_token_expired?
  end
end
