module UsersHelper
  def user_profile_image_link(user)
    current_user.profile_image.present? ? rails_blob_path(current_user.profile_image, disposition: 'attachment') : 'default.jpeg'
  end
end
