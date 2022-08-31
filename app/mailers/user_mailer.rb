class UserMailer < ApplicationMailer
  def verification(user)
    @user = user
    mail to: user.email, subject: 'Verification mail for new account'
  end
end
