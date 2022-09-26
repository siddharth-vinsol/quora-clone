class AttachedFileTypeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    content_type = value.content_type
    record.errors.add attribute, I18n.t('invalid_filetype', file_types: options[:types].join(' ')) unless options[:types].include?(content_type)
  end
end
