class UserMailer < ApplicationMailer
  def verification(user)
    @user = user
    mail to: user.email, subject: t('verification_subject')
  end

  def reset_password(user)
    @user = user
    mail to: user.email, subject: t('password_reset_subject')
  end

  def answer_posted(answer_id)
    @answer = Answer.find_by(id: answer_id)
    @question = @answer.question
    @question_user = @question.user
    @answer_user = @answer.user
    mail to: @question_user.email, subject: t('answer_posted')
  end
end
