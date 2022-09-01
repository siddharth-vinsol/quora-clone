class RegistrationsController < ApplicationController
  skip_before_action :authorize

  def create
    @user = User.new(user_params)
    @user.confirmation_token = SecureRandom.uuid

    if @user.save
      redirect_to login_path, notice: 'Thank you for signing up, a verification email has been sent to your account.'
    else
      render :signup, status: :unprocessable_entity
    end
  end

  def show
    @user = User.new
  end

  def validate
    if params[:confirmation_token] && @user = User.find_by(confirmation_token: params[:confirmation_token])
      @user.update_columns(confirmation_token: nil, verified_at: Time.current)
      render :validate, notice: 'Account has been verified, please login again.'
    else
      redirect_to login_path, notice: 'Cannot verify your account.'
    end
  end

  private def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end