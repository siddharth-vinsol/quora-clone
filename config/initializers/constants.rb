module QuoraClone
  module RegexConstants
    EMAIL_REGEX = /\A(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})\z/i
  end

  module Mailer
    FROM_MAIL = 'admin@quora-clone.com'
  end

  module Session
    COOKIE_EXPIRATION_TIME = 1.day
  end
  
  module Token
    TOKEN_EXPIRATION_TIME = 1.day
  end
  
  module AbuseReport
    ABUSE_REPORT_THRESHOLD = 2
  end
end
