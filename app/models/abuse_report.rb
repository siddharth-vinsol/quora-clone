class AbuseReport < ApplicationRecord
  after_create_commit :process_reportable

  belongs_to :abuse_reportable, polymorphic: true
  belongs_to :user

  validates :reason, presence: true
  validates :user_id, uniqueness: { scope: [:abuse_reportable_id, :abuse_reportable_type] }

  def process_reportable
    if abuse_reportable.abuse_reports.count >= QuoraClone::AbuseReport::ABUSE_REPORT_THRESHOLD
      abuse_reportable.unpublish
    end
  end
end
