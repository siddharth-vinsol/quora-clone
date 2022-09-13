class UsersController < ApplicationController
  def show
  end

  def update
    if current_user.update_profile_details(user_params)
      redirect_to profile_path, notice: t('profile_update_success')
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  private def user_params
    params.require(:user).permit(:name, :profile_image, :password, :password_confirmation)
  end
end
