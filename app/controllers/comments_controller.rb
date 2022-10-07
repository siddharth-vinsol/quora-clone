class CommentsController < ApplicationController
  before_action :load_commentable, only: [:create]
  before_action :set_comment, only: [:destroy]
  before_action :validate_current_user_resource, only: [:destroy] 

  def create
    @new_comment = @commentable.comments.build(content: comment_params[:content], user_id: current_user.id, published_at: Time.current)

    if @new_comment.save
      redirect_to request.referrer, notice: t('comment_added')
    else
      flash[:notice] = @new_comment.errors.full_messages.first
      redirect_to request.referrer, status: :unprocessable_entity
    end
  end

  def destroy
    if @comment.destroy
      redirect_to request.referrer, notice: t('comment_deleted')
    else
      render 'questions/show', status: :unprocessable_entity
    end
  end

  private def load_commentable
    @commentable = comment_params[:commentable_type].constantize.find(comment_params[:commentable_id])
  end

  private def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :content)
  end

  private def set_comment
    @comment = Comment.find(params[:id])
  end

  private def resource
    @comment
  end
end
