class QuestionsController < ApplicationController
  before_action :enough_credits_on_user, only: [:new, :create]
  before_action :set_question, except: [:index, :new, :create]
  before_action :validate_current_user_resource, only: [:publish, :edit, :update, :destroy]

  def index
    @q = Question.where(user: current_user).order('created_at DESC').ransack(params[:q])
    @questions = @q.result
  end

  def new
    @question = current_user.questions.build
  end

  def create
    @question = current_user.questions.build(question_params)
    @question.publish if params[:draft].blank?

    if @question.save
      message = @question.published_at? ? t('notice.user.question.publish_success') : t('notice.user.question.draft_success')
      redirect_to user_path, notice: message
    else
      render :new, status: :unprocessable_entity
    end
  end

  def publish
    if @question.publish
      redirect_to user_questions_path, notice: t('notice.user.question.publish_success')
    else
      render :index, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @question.update_attachment(params[:attachment]) if question_params[:attachment]
    @question.publish if params[:draft].blank?

    if @question.update(question_params)
      message = @question.published_at? ? t('notice.user.question.publish_success') : t('notice.user.question.draft_success')
      redirect_to user_path, notice: message
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @question.destroy
      redirect_to questions_path, notice: t('notice.user.question.destroy_success')
    else
      redirect_to user_path, status: :unprocessable_entity
    end
  end

  private def question_params
    params.require(:question).permit(:title, :content, :attachment)
  end

  private def set_question
    @resource = @question = Question.find_by_permalink(params[:permalink])
  end

  private def enough_credits_on_user
    redirect_to user_path, notice: t('notice.user.question.low_credits_error') unless current_user.enough_credits_to_post_question?
  end
end
