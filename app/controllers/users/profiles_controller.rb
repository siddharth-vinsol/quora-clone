class Users::ProfilesController < ApplicationController
  def show
  end

  def update
  end

  def image
    if @user.change_profile_picture(params[:user][:profile_image])
      redirect_to :show, notice: t('user.profile.profile_image_upload_success')
    else
      redirect_to :show, notice: t('user.profile.profile_image_upload_failed')
    end
  end
end
