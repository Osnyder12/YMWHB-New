class ApplicationController < ActionController::Base
  before_action :current_user
  # skip_before_action :verify_authenticity_token

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  helper_method :current_user

  def authorize
    return if current_user.present?

    session[:return_to] = request.path
    redirect_to root_path
  end
end
