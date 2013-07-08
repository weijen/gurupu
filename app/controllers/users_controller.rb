class UsersController < ApplicationController
  before_action :set_group
  before_action :set_user, only: [:update, :destroy]

  def index
    @is_owner = current_user.is_owner_of?(@group)
  end

  def new
  end

  def create
    group_user = current_user.group_users.build(group: @group,
      role: :member, state: :wait)
    group_user.save
    redirect group_expenses_path(@group)
  end

  private
  def set_group
    @group = Group.find_by_slug(params[:group_id])
  end

  def set_user
    @user = User.find(params[:id])
  end
end
