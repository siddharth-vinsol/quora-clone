class Admin::AdminsController < Admin::BaseController
  before_action :set_user, only: [:disable_user_account]

  def show
  end

  def users
    @users = User.where.not(id: current_user.id)
  end

  def questions
  end

  def disable_user_account
    if params[:should_disable] == '1'
      status = Time.current
      message = t('notice.user.admin.user_disable_success')
    else
      status = nil
      message = t('notice.user.admin.user_enable_success')
    end

    @user.change_disable_status(status)
    redirect_to users_admin_path, notice: message
  end

  private def set_user
    redirect_to users_admin_path, notice: t('notice.user.admin.user_not_found') unless @user = User.find_by(id: params[:user_id])
  end
end
