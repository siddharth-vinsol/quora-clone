class NotificationsController < ApplicationController
  def unsent
    @notifications = current_user.notifications.where(sent: false)
    render json: { status: :ok, notifications: @notifications }
  end
end
