class QuestionsController < ApplicationController
  before_action :set_question, only: [:publish, :edit, :update, :destroy, :remove_attachment]
  before_action :load_question_with_answer_comment, only: [:show]
  before_action :validate_current_user_resource, only: [:publish, :edit, :update, :destroy, :remove_attachment]
  after_action :send_posted_notification, only: [:create, :publish, :update]
  skip_before_action :authorize, only: [:show]
  skip_before_action :verify_authenticity_token, only: [:remove_attachment]

  def index
    @q = Question.includes(:rich_text_content, :attachment_attachment).of_user(current_user).by_recently_created.ransack(params[:q])
    @questions = @q.result
  end

  def new
    @question = current_user.questions.build
  end

  def create
    @question = current_user.questions.build(question_params)
    @question.should_publish = params[:publish]
    
    if @question.save
      message = @question.published_at? ? t('publish_success') : t('draft_success')
      redirect_to questions_path, notice: message
    else
      render :new, status: :unprocessable_entity
    end
  end

  def publish
    if @question.publish
      redirect_to questions_path, notice: t('publish_success')
    else
      redirect_to questions_path, notice: @question.errors[:published_at].first
    end
  end

  def edit
  end

  def show
    @new_answer = @question.answers.build
    @new_comment = @question.comments.build

    @question.sorted_answers.each do |answer|
      answer.sorted_comments.build
    end
  end

  def update
    @question.should_publish = params[:publish]
    @question.attachment = nil
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

  def remove_attachment
    @question.attachment.purge
    render json: { status: :ok }
  end

  private def question_params
    params.require(:question).permit(:title, :content, :attachment, topic_list: [])
  end

  private def resource
    @question
  end

  private def set_question
    @question = Question.find_by_permalink(params[:permalink])
  end

  private def load_question_with_answer_comment
    @question = Question.includes({ sorted_answers: [:user, :rich_text_content] }, { sorted_comments: [:user] }, :topics).find_by_permalink(params[:permalink])
  end

  private def send_posted_notification
    if @question.persisted? && @question.published_at?
      ActionCable.server.broadcast('new_question_posted', {
        status: 200
      })
    end
  end
end
