class Admin::AdminsController < Admin::BaseController
  before_action :set_user, only: [:disable_user]

  def show
  end

  def users
    @users = User.where.not(id: current_user.id)
  end

  def questions
    @questions = Question.includes(:user)
  end

  def disable_user
    if params[:should_disable] == '1'
      disable_time = Time.now
      message = t('user_disable_success')
    else
      disable_time = nil
      message = t('user_enable_success')
    end

    if @user.update(disabled_at: disable_time)
      redirect_to users_admin_path, notice: message
    else
      redirect_to '404'
    end
  end

  private def set_user
    @user = User.find(params[:user_id])
  end
end
