class SessionsController < ApplicationController
  skip_before_action :authorize, only: [:new, :create, :sign_up, :register]

  def new
    return unless current_user

    redirect_to root_path
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate
      session[:user_id] = user.id.to_s
      redir_path = session[:return_to].blank? ? root_path : session[:return_to]
      session[:return_to] = nil
      redirect_to redir_path, notice: 'Successfully logged in!'
    else
      redirect_back fallback_location: { action: :new },
                    alert: 'Incorrect email or password, try again.'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to sign_in_path, notice: 'Logged out!'
  end

  # GET /sign_up
  def sign_up; end

  # POST /sign_up
  def register
    user = User.new(email: params[:email], password: params[:password])

    if user.save
      session[:user_id] = user.id.to_s
      redir_path = session[:return_to].blank? ? root_path : session[:return_to]
      session[:return_to] = nil
      redirect_to redir_path, notice: 'Successfully created account!'
    else
      redirect_back fallback_location: { action: :new },
                    alert: 'Email or password did not work.'
    end
  end
end