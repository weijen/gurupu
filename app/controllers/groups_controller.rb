class GroupsController < ApplicationController
  #maca before_action :set_group, only: [:show, :edit, :update, :destroy]
  prepend_before_action :set_group, except: [:new, :create] #maca 
  before_action :select_tag, only: [:new, :edit, :index]    #maca 

  def index
    @groups=current_user.groups #maca
    #maca @groups = Group.all
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
        GroupUser.find(i).change_state('kick')
      end
    elsif params[:var]=="own"
      old_owner=@group.group_users.where(role: 'admin')
      old_owner.each do |gu|        
        #if !((params[:user_ids] || []).include?(gu.id)) 
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
      @group.tags.delete_all
      (params[:tag_ids] || []).each { |i| @group.tags << Tag.find(i) }             
      redirect_to edit_group_path
      #maca add end
    else
      render action: 'edit'
    end
  end

=begin
  def destroy
    @group.destroy
    redirect_to groups_path
  end
=end

  private
  def set_group
    @group = Group.find_by_slug(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description)
  end

end

