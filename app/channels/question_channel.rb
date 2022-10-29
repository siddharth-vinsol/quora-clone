class QuestionChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'new_question_posted'
  end

  def unsubscribed
  end
end
