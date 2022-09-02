class PasswordsController < ApplicationController
  skip_before_action :authorize

  before_action :current_user_by_password_reset_token, only: [:reset, :update_user_password]
  after_action :password_reset_email, only: [:generate_reset_token]

  def show
  end

  def generate_reset_token
    if current_user_by_email
      @user.update_password_reset_token
      message = 'Password reset mail sent to your email'
    else
      message = 'No such registered email exists'
    end
    redirect_to password_path, notice: message
  end

  def reset
  end

  def update_user_password
    if @user.update_password(reset_password_params[:password], reset_password_params[:password_confirmation])
      redirect_to login_path, notice: 'Password reset successfully'
    else
      render :reset, status: :unprocessable_entity
    end
  end

  private def reset_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  private def password_reset_email
    UserMailer.reset_password(@user).deliver_later
  end

  private def current_user_by_password_reset_token
    unless params[:password_reset_token].present? && @user = User.find_by(password_reset_token: params[:password_reset_token])
      redirect_to password_path, notice: 'Invalid password reset request'
    end
  end
end
