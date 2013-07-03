class GroupsController < ApplicationController
  #maca before_action :set_group, only: [:show, :edit, :update, :destroy]
  prepend_before_action :set_group, except: [:new, :create]  #maca
  before_action :select_tag, only: [:new, :create, :edit, :update, :index]  #maca

  def index
    @groups=current_user.groups #maca
  end

	#maca add start
  def state_change
    @group.change_state
    redirect_to edit_group_path
  end

  def user_maintain
    if params[:var]=="add"
      (params[:group_user_ids] || []).each do |i|
        GroupUser.find(i).change_state('joined')
      end
    elsif params[:var]=="kick"
      (params[:group_user_ids] || []).each do |i|
        GroupUser.find(i).delete
      end
    elsif params[:var]=="own"
      old_owner=@group.group_users.where(role: 'admin')
      old_owner.each do |gu|
        if !((params[:group_user_ids] || []).include?(gu.id.to_s))
          gu.change_role('')
        end
      end
      (params[:group_user_ids] || []).each do |i|
        if !(old_owner.include?(GroupUser.find(i)))
          GroupUser.find(i).change_role('admin')
        end
      end
    end
    redirect_to edit_group_path
  end

  def add_tag
    tag_name=params[:tag][:name].lstrip.rstrip
    if Tag.find_by_name(tag_name)==nil
      tag_id = Tag.create(name:tag_name, is_default:0).id
    else
      tag_id = Tag.find_by_name(tag_name)
    end
    if GroupTag.find_by_tag_id(tag_id)==nil
      GroupTag.create(group_id: @group.id, tag_id: tag_id)
    end
    redirect_to edit_group_path
  end

  def join_group
    @group.add_member(current_user)
    redirect_to :back
  end
	#maca add end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    #maca @group.cost = 'active'
    @group.state = 'active' #maca
    if @group.save
      #maca redirect_to @group
      #maca add start
      @group.add_owner(current_user)
      (params[:tag_ids] || []).each { |i| @group.tags << Tag.find(i) }
      redirect_to groups_path
      #maca add end
    else
      render action: 'new'
    end
  end

  def edit
    @wait_user=@group.group_users.where(state: 'wait')     	#maca
    @all_member=@group.group_users.where(state: 'joined')   #maca
  end

  def show
  end

  def update
    if @group.update(group_params)
      #maca redirect_to @group
      #maca add start
      #----------------------------------------
      # group tags maintain
      # if expenses exist, cannot remove tag
      #----------------------------------------
      @group_sel_tag.each do |tag|
        if (params[:tag_ids] || []).include?(tag.id.to_s)
          if !(@group.tags.include?(tag))
            @group.tags << tag
          end
        else
          if !(@group.expenses.find_by_tag_id(tag.id))
            if @group.tags.include?(tag)
              GroupTag.find_by_group_id_and_tag_id(@group.id, tag.id).delete
            end
          end
        end
      end
      redirect_to edit_group_path
      #maca add end
    else
      render action: 'edit'
    end
  end

  def invite
   GroupMailer.invite(current_user, @group,params[:mailto]).deliver
   redirect_to edit_group_path, :notice => "mailed:" + params[:mailto]
  end

  private
  #maca add start
  def select_tag
    @group_sel_tag = Tag.all.where(is_default: true)
    if @group != nil
      @group_sel_tag += @group.tags.where(is_default: false)
    end
  end
  #maca add end

  def set_group
    @group = Group.find_by_slug(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description)
  end

end

