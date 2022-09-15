class ReportableValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if record.abuse_reports.count >= QuoraClone::AbuseReport::ABUSE_REPORT_THRESHOLD
      record.errors.add attribute, I18n.t('not_publishable')
    end
  end
end
