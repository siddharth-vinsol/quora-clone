class RegistrationsController < ApplicationController
  skip_before_action :authorize

  before_action :set_user, only: [:verify_email]

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to login_path, notice: t('signup_success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @user = User.new
  end

  def verify_email
     if @user.verify
      redirect_to login_path, notice: t('verification_success')
    else
      redirect_to login_path, notice: t('verification_failure')
    end
  end

  private def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
  end

  private def set_user
    unless params[:confirmation_token].present? && @user = User.find_by(confirmation_token: params[:confirmation_token])
      redirect_to login_path, notice: t('verification_failure')
    end
  end
end
