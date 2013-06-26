class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group.new(group_params)
    if @group.save
      redirect_to @group
    else
      render action: 'new'
    end
  end

  def edit
  end

  def show
  end

  def update
    if @group.update(group_params)
      redirect_to @group
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
    @group = Group.where(secret_str: params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description)
  end

end
