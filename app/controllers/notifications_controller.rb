class NotificationsController < ApplicationController
  def unsent
    @notifications = current_user.notifications.where(sent: false)
    render json: { status: 200, notifications: @notifications }
  end
  
  def unread
    @notifications = current_user.notifications.where(read_at: nil)
    render json: { status: 200, notifications: @notifications }
  end
end
