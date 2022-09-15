class UserMailer < ApplicationMailer
  def verification(user)
    @user = user
    mail to: user.email, subject: t('verification_subject')
  end

  def reset_password(user)
    @user = user
    mail to: user.email, subject: t('password_reset_subject')
  end

  def answer_posted(question, question_user, answer, answer_user)
    @question = question
    @question_user = question_user
    @answer = answer
    @answer_user = answer_user
    mail to: question_user.email, subject: 'Someone posted an answer on your question'
  end
end
