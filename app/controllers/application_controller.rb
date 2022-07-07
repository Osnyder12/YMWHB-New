class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def authorize
    return if current_user.present?

    session[:return_to] = request.path
    redirect_to root_path
  end
end
