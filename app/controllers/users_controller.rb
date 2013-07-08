class UsersController < ApplicationController
  before_action :set_group
  before_action :set_user, only: [:update, :destroy]
  before_action :check_permission, only: [:destroy]

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

  def destroy
    if @user.is_owner_of?(@group)
      redirect_to @group, error: 'Permission denied'
    else
      @group.members.delete(@user)
      redirect_to group_users_path(@group)
    end
  end

  private
  def set_group
    @group = Group.find_by_slug(params[:group_id])
  end

  def set_user
    @user = User.find(params[:id])
  end

  def check_permission
    if current_user == nil || !current_user.is_owner_of?(@group)
      redirect @group, error: 'Permission denied'
    end
  end
end
