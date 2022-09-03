class Users::ProfilesController < ApplicationController
  def show
  end

  def update
    if @user.change_profile_details(user_profile_params[:name])
      redirect_to user_profile_path, notice: t('notice.user.profile.update_success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def image
    if @user.change_profile_picture(params[:user][:profile_image])
      redirect_to user_profile_path, notice: t('user.profile.profile_image_upload_success')
    else
      redirect_to user_profile_path, notice: t('user.profile.profile_image_upload_failed')
    end
  end

  def edit
  end

  private def user_profile_params
    params.require(:user).permit(:name)
  end
end
