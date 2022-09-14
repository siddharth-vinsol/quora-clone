class CommentsController < ApplicationController
  before_action :set_question, only: [:create]

  def create
    @new_comment = @question.comments.build(content: comment_params[:content], user_id: current_user.id)

    if @new_comment.save
      redirect_to question_path(comment_params[:permalink]), notice: t('comment_added')
    else
      render 'questions/show', status: :unprocessable_entity
    end
  end

  private def set_question
    @question = Question.find(comment_params[:question_id])
  end

  private def comment_params
    params.require(:comment).permit(:question_id, :content, :permalink)
  end
end
