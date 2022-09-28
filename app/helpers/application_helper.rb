module ApplicationHelper
  def render_filelink_if_exists(file)
    sanitize "<a href=#{rails_blob_path(file, disposition: 'attachment')} >Attached File</a>" if file.present?
  end

  def filename_from_file(file)
    file.filename.to_s
  end

  def current_user_resource?(resource, user)
    resource.user_id == user.id
  end
end
