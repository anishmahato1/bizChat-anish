module ParticipantsHelper
  # check for super admin or group admin
  def admin?
    current_user.is_admin || (current_user == @channel.admin)
  end
end
