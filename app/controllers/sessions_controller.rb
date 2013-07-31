class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    session[:fb_token] = auth["credentials"]["token"]

    if current_user.groups.present?
      redirect_to request.env['omniauth.origin'] || groups_path
    else
      redirect_to welcome_newbie_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!";
  end

  def index
  end
end
