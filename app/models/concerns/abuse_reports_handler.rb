module AbuseReportsHandler
  def self.included(klass)
    klass.class_eval do
      has_many :abuse_reports, as: :abuse_reportable
      validates :published_at, reportable: true, if: :published_at?
    end 
  end

  def unpublish
    update(published_at: nil)
    remove_credit_on_unpublish
  end

  private def remove_credit_on_unpublish
    if transaction = user.credit_transactions.where(entity: self).last.try(:credit?)
      user.update_credits(-1, self, 'Report Penalty')
    end
  end
end
