module NotificationsHandler
  def self.included(klass)
    klass.class_eval do
      include Rails.application.routes.url_helpers
    end
  end
end
