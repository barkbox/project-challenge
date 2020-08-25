module UsersHelper
  def can_edit?(dog)
    current_user.owner_of?(dog)
  end
end

