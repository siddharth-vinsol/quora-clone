class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :content, :read_at, :redirect_link, :created_at

  def redirect_link
    object.notifiable.redirect_link
  end
end
