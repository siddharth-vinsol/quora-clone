class Api::V1::TopicsController < Api::V1::BaseController
  skip_before_action :authorize

  def index
    render json: Topic.all
  end

  def show
    @questions = Question.tagged_with(params[:topic]).includes(:user, :rich_text_content, { sorted_answers: [:user, :rich_text_content] }, { sorted_comments: [:user] }, :topics).published_only.not_disabled.by_recently_created.limit(params[:x])
    render json: @questions, each_serializer: QuestionSerializer, include: ['user', 'answers.user', 'answers.comments.user', 'comments.user']
  end
end
