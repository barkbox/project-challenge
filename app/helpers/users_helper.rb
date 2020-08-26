module UsersHelper
  def can_edit?(dog)
    logged_in? &&
      current_user.owner_of?(dog)
  end

  def can_like?(dog)
    logged_in? &&
      !current_user.owner_of?(dog)
  end

  private

  def logged_in?
    current_user.present?
  end
end

