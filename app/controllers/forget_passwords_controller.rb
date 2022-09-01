class ForgetPasswordsController < ApplicationController
  skip_before_action :authorize

  def show
  end

  def create
    if @user = User.find_by(email: params[:email])
      @user.update_columns(password_reset_token: SecureRandom.uuid)
      UserMailer.reset_password(@user).deliver_later
      message = 'Password reset mail sent to your email'
    else
      message = 'No such registered email exists'
    end
    redirect_to forget_password_path, notice: message
  end

  def reset
    if params[:password_reset_token] && @user = User.find_by(password_reset_token: params[:password_reset_token])
      render :reset
    else
      redirect_to forget_password_path, notice: 'Invalid password reset request'
    end
  end

  def update
    @user = User.find_by(password_reset_token: params[:password_reset_token])
    if @user.update(reset_password_params.merge(password_reset_token: nil, password_reset_at: Time.now))
      redirect_to login_path, notice: 'Password reset successfully'
    else
      render :reset, status: :unprocessable_entity
    end
  end

  private def reset_password_params
    p params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
