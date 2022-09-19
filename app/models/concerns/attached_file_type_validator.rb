class AttachedFileTypeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    filename = value.filename.to_s
    record.errors.add :attribute, I18n.t('invalid_filetype', file_types: options[:types].join(' ')) unless filename.ends_with?(*options[:types])
  end
end
