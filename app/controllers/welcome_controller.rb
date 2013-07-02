class WelcomeController < ApplicationController
  prepend_before_action :flash_clear 
  def index
  end
end
