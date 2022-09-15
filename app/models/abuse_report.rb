class AbuseReport < ApplicationRecord
  belongs_to :abuse_reportable, polymorphic: true
  belongs_to :user

  validates :reason, presence: true
end
