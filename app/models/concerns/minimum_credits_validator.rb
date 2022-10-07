class MinimumCreditsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if record.user.credits < QuoraClone::Credits::MINIMUM_CREDITS_FOR_QUESTION
      record.errors.add attribute, I18n.t('not_enough_credits')
    end
  end
end
