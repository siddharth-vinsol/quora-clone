class UsersController < ApplicationController
  before_action :validate_old_password, only: [:update_password]
  before_action :set_user, only: [:show]

  def profile
  end

  def edit
  end

  def password
  end

  def show
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path, notice: t('profile_update_success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update_password
    if current_user.update(user_params)
      redirect_to user_path, notice: t('password_update_success')
    else
      render :password, status: :unprocessable_entity
    end
  end

  def credit_transactions
    @credit_transactions = current_user.credit_transactions
  end

  private def user_params
    params.require(:user).permit(:name, :username, :profile_image, :password, :password_confirmation, topic_list: [])
  end

  private def validate_old_password
    unless current_user.authenticate(params[:user][:old_password])
      redirect_to password_user_path, notice: t('old_password_not_matching')
    end
  end

  private def set_user
    unless @user = User.find_by(username: params[:username])
      redirect_to user_path, notice: ('profile_not_found')
    end
  end
end
