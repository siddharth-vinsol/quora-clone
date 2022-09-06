class QuestionsController < ApplicationController
  before_action :set_question, only: [:publish]

  def index
    @questions = Question.where(user: current_user)
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
    if validate_current_user_resource(@product) && @product.publish
      redirect_to user_questions_path, notice: t('notice.user.question.publish_success')
    else
      render :index, status: :unprocessable_entity
    end
  end

  def edit
  end

  private def question_params
    params.require(:question).permit(:title, :content, :attachment)
  end

  private def set_question
    @product = Question.find(params[:id])
  end
end
