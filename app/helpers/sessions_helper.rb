module SessionsHelper
  def log_user_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @curerent_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end
end
