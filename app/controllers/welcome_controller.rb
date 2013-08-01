class WelcomeController < ApplicationController
  def index
    if login?
      redirect_to groups_path
    else
      render layout: false
    end
  end

  def newbie
  end
end
