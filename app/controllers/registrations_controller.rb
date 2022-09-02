class RegistrationsController < ApplicationController
  skip_before_action :authorize

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to login_path, notice: 'Thank you for signing up, a verification email has been sent to your account.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @user = User.new
  end

  def verify_email
    if current_user_by_confirmation_token
      @user.update_columns(confirmation_token: nil, verified_at: Time.current)
      render :verify_email, notice: 'Account has been verified, please login again.'
    else
      redirect_to login_path, notice: 'Cannot verify your account.'
    end
  end

  private def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  private def current_user_by_confirmation_token
    params[:confirmation_token].present? && @user = User.find_by(confirmation_token: params[:confirmation_token])
  end
end
