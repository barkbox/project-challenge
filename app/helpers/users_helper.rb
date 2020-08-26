module UsersHelper
  def can_edit?(dog)
    current_user.owner_of?(dog)
  end

  def can_like?(dog)
    !current_user.owner_of?(dog)
  end
end

