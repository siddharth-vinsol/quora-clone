class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :content, :read_at, :redirect_link, :created_at
end
