class Api::V1::UsersController < Api::V1::BaseController
  def feed
    @questions = Question.tagged_with(current_user.topic_list).includes(:user, :rich_text_content, { sorted_answers: [:user, :rich_text_content] }, { sorted_comments: [:user] }, :topics).published_only.not_disabled.by_recently_created
    render json: @questions, each_serializer: QuestionSerializer, include: ['user', 'answers.user', 'answers.comments.user', 'comments.user']
  end
end
