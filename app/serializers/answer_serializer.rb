class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :content, :total_upvotes, :total_downvotes
  belongs_to :user
  has_many :comments

  def content
    object.content.body
  end
end
