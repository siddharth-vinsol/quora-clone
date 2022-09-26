class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :total_upvotes, :total_downvotes, :permalink
  belongs_to :user
  has_many :answers
  has_many :comments
end
