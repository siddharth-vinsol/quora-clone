class QuestionsController < ApplicationController
  def index
  end

  def new
    @question = current_user.questions.build
  end

  def create
    @question = current_user.questions.build(question_params)
    @question.published_at = Time.current if params[:draft] == '0'

    if @question.save
      message = @question.published_at? ? t('notice.user.question.publish_success') : t('notice.user.question.draft_success')
      redirect_to user_path, notice: message
    else
      render :new, status: :unprocessable_entity
    end
  end

  private def question_params
    params.require(:question).permit(:title, :content, :attachment)
  end
end
