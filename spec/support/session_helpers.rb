module SessionHelpers
  def sign_in(user = nil)
    user = user || create(:user)
    page.driver.post user_session_path, user: { email: user.email, password: user.password }
  end
end

