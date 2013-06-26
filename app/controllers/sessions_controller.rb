class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    session[:fb_token] = auth["credentials"]["token"]
    redirect_to login_url, :notice => "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url, :notice => "Signed out!";
  end

  def index
  end
end
