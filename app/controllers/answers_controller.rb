class AnswersController < ApplicationController
  before_action :set_question, only: [:create]

  def create
    @new_answer = @question.answers.build(content: answer_params[:content], user_id: current_user.id, published_at: Time.now)

    if @new_answer.save
      redirect_to question_path(answer_params[:permalink]), notice: t('submit_success')
    else
      render 'questions/show', status: :unprocessable_entity
    end
  end

  private def set_question
    @question = Question.find(answer_params[:question_id])
  end

  private def answer_params
    params.require(:answer).permit(:question_id, :content, :permalink)
  end
end
