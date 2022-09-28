class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :content, :read_at, :redirect_link, :created_at

  def redirect_link
    p object
    p object.notifiable
    object.notifiable.redirect_link
  end
end
