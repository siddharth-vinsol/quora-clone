class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :total_upvotes, :total_downvotes
  belongs_to :user
end
