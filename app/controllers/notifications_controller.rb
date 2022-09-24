class NotificationsController < ApplicationController
  before_action :load_notifications

  def show
  end

  def unsent
    render json: { status: 200, notifications: @notifications.where(sent: false) }
  end
  
  def unread
    render json: { status: 200, notifications: @notifications.where(read_at: nil) }
  end

  def mark_sent
    if @notifications.update(sent: true)
      render json: { status: 200 }
    else
      render json: { status: 400 }
    end
  end

  private def load_notifications
    @notifications = current_user.notifications.by_recently_created
  end
end
