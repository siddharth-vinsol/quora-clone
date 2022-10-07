module AbuseReportsHandler
  def self.included(klass)
    klass.class_eval do
      has_many :abuse_reports, as: :abuse_reportable
      validates :published_at, reportable: true, if: :published_at?
    end 
  end

  def unpublish
    update(published_at: nil)
  end
end
