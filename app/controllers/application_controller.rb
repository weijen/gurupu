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
    return !session[:user_id].nil?
  end

  #maca add start
  def select_tag
    @group_sel_tag = Tag.all.where(is_default: true)
    if @group != nil
     @group_sel_tag += @group.tags.where(is_default: false)    
    end
  end
  #maca add end
end
