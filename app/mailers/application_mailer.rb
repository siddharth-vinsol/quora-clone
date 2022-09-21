class ApplicationMailer < ActionMailer::Base
  default from: QuoraClone::Mailer::FROM_MAIL
  layout "mailer"
end
