class QuestionsController < ApplicationController
  before_action :set_question, only: [:publish, :edit, :update, :destroy, :show]
  before_action :validate_current_user_resource, only: [:publish, :edit, :update, :destroy]
  skip_before_action :authorize, only: [:show]

  def index
    @q = Question.includes(:rich_text_content, :attachment_attachment).user_questions(current_user).chronological_order.ransack(params[:q])
    @questions = @q.result
  end

  def new
    @question = current_user.questions.build
  end

  def create
    @question = current_user.questions.build(question_params)
    @question.publish = true if params[:publish].present?
    
    if @question.save
      message = @question.published_at? ? t('publish_success') : t('draft_success')
      redirect_to questions_path, notice: message
    else
      render :new, status: :unprocessable_entity
    end
  end

  def publish
    @question.publish = true

    if @question.save
      redirect_to questions_path, notice: t('publish_success')
    else
      render :index, status: :unprocessable_entity
    end
  end

  def edit
  end

  def show
  end

  def update
    @question.publish = true if params[:publish].present?
    
    if @question.update(question_params)
      message = @question.published_at? ? t('publish_success') : t('draft_success')
      redirect_to questions_path, notice: message
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @question.destroy
      redirect_to questions_path, notice: t('destroy_success')
    else
      redirect_to questions_path, status: :unprocessable_entity
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
