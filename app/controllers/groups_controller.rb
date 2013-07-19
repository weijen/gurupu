class GroupsController < ApplicationController
  prepend_before_action :set_group, except: [:new, :create]  
  before_action :select_tag, only: [:new, :create, :edit, :update, :index]  

  def index
    @groups = current_user.groups
  end
 
  def state_change
    if @group.change_state(params[:state])
    else
      flash[:error] = 'Status change fail !!'
    end      
    redirect_to edit_group_path
  end

  def quit
    trashed = (@group.group_users.where(state:"join").size==1)
    if (!trashed) && (current_user.is_owner_of?(@group)) && (@group.owners.size == 1)
      flash[:error] = "您是本團唯一的管理員，需指派繼任管理員才可退出團體"
      redirect_to :back
      return
    end
    msg=""
    if trashed
      @group.change_state('trashed')
      msg="and drop "
    end
    current_user.quit!(@group)

    flash[:notice] = "Quit "+msg+@group.name+" success" 
    redirect_to groups_path
  end

  def new
    @group = Group.new
  end

  def create  
    @group = Group.new(group_params)  
    @group.state = 'active' 
    if @group.save
      @group.add_owner(current_user)
      (params[:tag_ids] || []).each { |i| @group.tags << Tag.find(i) }
      
      flash[:notice] = "Create Group success" 
      redirect_to edit_group_path(@group)
    else
      render action: 'new'
    end
  end

  def edit
  end

  def show
    unless current_user.is_member_of?(@group)
      redirect_to new_group_user(@group)
    end
  end

  def update
    if @group.update(group_params)
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
              @group.tags.delete(tag)
            end
          end
        end
      end
      flash[:notice] = "Update Group success" 
      redirect_to edit_group_path
    else
      render action: 'edit'
    end
  end

  def invite
   GroupMailer.invite(current_user, @group,params[:mailto]).deliver
   redirect_to edit_group_path, :notice => "mailed:" + params[:mailto]
  end

  private
  def select_tag
    @group_sel_tag = Tag.all.where(is_default: true)
    if @group != nil
      @group_sel_tag += @group.tags.where(is_default: false)
    end
  end

  def set_group
    @group = Group.find_by_slug(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description)
  end

end

