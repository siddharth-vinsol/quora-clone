class CommentsController < ApplicationController
  before_action :set_commentable, only: [:create]

  def create
    @new_comment = @commentable.comments.build(content: comment_params[:content], user_id: current_user.id)

    if @new_comment.save
      redirect_to request.referrer, notice: t('comment_added')
    else
      render 'questions/show', status: :unprocessable_entity
    end
  end

  private def set_commentable
    @commentable = comment_params[:commentable_type].constantize.find(comment_params[:commentable_id])
  end

  private def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :content)
  end
end
