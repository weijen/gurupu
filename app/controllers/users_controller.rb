class UsersController < ApplicationController
  before_action :set_group, except: [:typeahead]
  before_action :check_group_status, except: [:typeahead]
  before_action :set_user, only: [:update, :destroy, :confirm]
  before_action :set_group_user, only: [:become_owner, :become_member, :confirm]
  before_action :check_permission, only: [:destroy, :confirm]

  def index
    @is_owner = current_user.is_owner_of?(@group)
  end

  def new
    @join_group_path = accept_group_users_path(@group)
  end

  def create
    group_user = current_user.group_users.build(group: @group,
      role: :member, state: :wait)
    group_user.save
    redirect_to group_expenses_path(@group)
  end

  def become_owner
    if @group_user.update(role: :admin)
      flash[:notice] = 'Successful update'
    else
      flash[:error] = 'Fail'
    end
    redirect_to group_users_path(@group_user.group)
  end

  def become_member
    if @group_user.user_id == current_user.id && @group_user.role.admin?
      if @group.owners.size == 1
        flash[:error] = '你是唯一的管理員'
      else
        @group_user.role = :member
        if @group_user.save
          flash[:notice] = 'Successful update'
        else
          flash[:error] = 'Fail'
        end
      end
    end
    redirect_to group_users_path(@group_user.group)
  end

  def confirm
    if @group_user.state.wait?
      @group_user.state = :join
    end
    if @group_user.save
      flash.now[:notice] = 'Successful update'
    else
      flash.now[:error] = 'Fail'
    end
    redirect_to group_users_path(@group_user.group)
  end

  def invite
    user = User.find_by(uid: params[:uid])
    unless user
      redirect_to group_users_path(@group), error: 'fail'
      return
    end
    group_user = GroupUser.new(user: user, group: @group,
      role: :member, state: :invite)
    if group_user.save
      flash[:notice] = 'Successful invite'
    else
      flash[:error] = 'Error'
    end
    redirect_to group_users_path(@group)
  end

  def accept
    group_user = GroupUser.find_by(group: @group, user: current_user)
    group_user.state = :join
    if group_user.save
      flash.now[:notice] = 'Successful join'
    else
      flash.now[:error] = 'Fail'
    end
    redirect_to group_path(@group)
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

  def check_group_status
    if @group.state.trashed?
      flash[:error] = 'This group is deleted'
      redirect_to groups_path
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_group_user
    @group_user = GroupUser.find_by(group: set_group, user_id: params[:id])
  end

  def check_permission
    if current_user == nil || !current_user.is_owner_of?(@group)
      flash[:error] = 'Permission denied'
      redirect_to @group
    end
  end

end
