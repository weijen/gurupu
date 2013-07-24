class InvitationsController < ApplicationController
  before_action :set_group, only: [:create]
  before_action :set_invitation, only: [:accept]

  def create
    invitation = Invitation.find_or_initialize_by(group: @group, user: current_user,
      email: params[:email])
    if invitation.save
      GroupMailer.invite(invitation).deliver
    else
      flash[:error] = 'Error'
    end
    redirect_to group_users_path(@group)
  end

  def accept
    group_user = GroupUser.new(user: current_user, group: @invitation.group,
      role: :member, state: :join)
    if group_user.save
      redirect_to group_path(@invitation.group)
    else
      redirect_to group_path(@invitation.group), error: 'accept error'
    end
  end

  private
  def set_group
    @invitation = Invitation.find_by_slug(params[:id])
  end

  def set_group
    @group = Group.find_by_slug(params[:group_id])
  end
end
