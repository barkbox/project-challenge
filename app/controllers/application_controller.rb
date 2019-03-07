class ApplicationController < ActionController::Base
  def require_login
    redirect_to dogs_url unless current_user
  end
end
