class QuestionsController < ApplicationController
  before_action :set_question, only: [:publish, :edit, :update, :destroy]
  before_action :set_question_with_answers, only: [:show]
  before_action :validate_current_user_resource, only: [:publish, :edit, :update, :destroy]
  skip_before_action :authorize, only: [:show]

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
      render :index, status: :unprocessable_entity
    end
  end

  def edit
  end

  def show
    @new_answer = Answer.new(question: @question)
  end

  def update
    @question.should_publish = params[:publish]
    
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
  
  private def set_question_with_answers
    @resource = @question = Question.includes(:sorted_answers).find_by_permalink(params[:permalink])
  end
end
