class UserMailer < ApplicationMailer
  def verification(user)
    @user = user
    mail to: user.email, subject: t('verification_subject')
  end

  def reset_password(user)
    @user = user
    mail to: user.email, subject: t('password_reset_subject')
  end
end
