class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :login?

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def login?
    if session[:user_id] 
      user = User.find(session[:user_id]) rescue nil
      if user
        return true
      else
        session[:user_id] = nil
        return false
      end
    else
      return false
    end
  end

end
