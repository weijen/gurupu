class UsersController < ApplicationController
  before_action :set_group
  before_action :set_user, only: [:update, :destroy]

  def new
  end

  def create
  end

  private
  def set_group
    @group = Group.find_by_slug(params[:group_id])
  end

  def set_user
    @user = User.find(params[:id])
  end
end
