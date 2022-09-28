module UsersHelper
  def user_profile_image_link(user)
    current_user.profile_image.present? ? rails_blob_path(current_user.profile_image, disposition: 'attachment') : 'default.jpeg'
  end

  def follow_button_text(user, other_user)
    user.follows?(other_user) ? 'Unfollow' : 'Follow'
  end

  def profile_image_attached?(user)
    user.profile_image.present?
  end
end
