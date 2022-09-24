class Notification < ApplicationRecord
  include CommonScopes
  
  belongs_to :notifiable, polymorphic: true
  belongs_to :user

  validates :content, presence: true
end
