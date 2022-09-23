class Admin::AdminsController < Admin::BaseController
  before_action :set_entity, only: [:disable_entity]

  def show
  end

  def users
    @users = User.where.not(id: current_user.id)
  end

  def questions
    @questions = Question.includes(:user).published_only
  end

  def disable_entity
    if params[:should_disable] == '1'
      disable_time = Time.now
      message = t('entity_disable_success', entity: params[:entity_type])
    else
      disable_time = nil
      message = t('entity_enable_success', entity: params[:entity_type])
    end

    if @entity.update(disabled_at: disable_time)
      redirect_to request.referrer, notice: message
    else
      redirect_to '404'
    end
  end

  private def set_entity
    @entity = params[:entity_type].constantize.find(params[:entity_id])
  end
end
