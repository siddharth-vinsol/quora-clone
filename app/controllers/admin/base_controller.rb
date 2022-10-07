class Admin::BaseController < ApplicationController
  before_action :authorize_admin

  protected def authorize_admin
    redirect_to user_path, notice: t('not_authorized') unless current_user.admin?
  end
end
