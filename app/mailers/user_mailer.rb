class UserMailer < ApplicationMailer
  def verification(user)
    @user = user
    mail to: user.email, subject: 'Verification mail for new account'
  end

  def reset_password(user)
    @user = user
    mail to: user.email, subject: 'Reset password link'
  end
end
