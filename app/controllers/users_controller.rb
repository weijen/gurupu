class UsersController < ApplicationController
  before_action :set_group
  before_action :set_user, only: [:update, :destroy, :role, :confirm]
  before_action :check_permission, only: [:destroy, :role, :confirm]

  def index
    @is_owner = current_user.is_owner_of?(@group)
  end

  def new
  end

  def create
    group_user = current_user.group_users.build(group: @group,
      role: :member, state: :wait)
    group_user.save
    redirect_to group_expenses_path(@group)
  end

  def role
    group_user = GroupUser.find_by(group: @group, user: @user)

    if @user.id == current_user.id && group_user.role.admin?
      if @group.owners.size == 1
        flash[:error] = '你是唯一的管理員'
        return redirect_to group_users_path(@group)
      end
      group_user.role = :member
    elsif group_user.role.member?
      group_user.role = :admin
    end
    if group_user.save
      flash[:notice] = 'Successful update'
    else
      flash[:error] = 'Fail'
    end
    redirect_to group_users_path(@group)
  end

  def confirm
    group_user = GroupUser.find_by(group: @group, user: @user)
    if group_user.state.wait?
      group_user.state = :join
    end
    if group_user.save
      flash.now[:notice] = 'Successful update'
    else
      flash.now[:error] = 'Fail'
    end
    redirect_to group_users_path(@group)
  end

  def destroy
    if @user.is_owner_of?(@group)
      redirect_to @group, error: 'Permission denied'
    else
      @group.members.delete(@user)
      redirect_to group_users_path(@group)
    end
  end

  def typeahead
    result = User.select(:uid, :name).
      where("lower(name) like ?", "#{params[:name].downcase}%").to_a
    render json: result.to_json(only: [:uid, :name])
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
