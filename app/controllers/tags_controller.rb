class TagsController < ApplicationController
	before_action :set_group

  def create
    tag_name=params[:tag][:name].lstrip.rstrip
    if Tag.find_by_name(tag_name)==nil
      tag_id = Tag.create(name:tag_name, is_default:0).id
    else
      tag_id = Tag.find_by_name(tag_name).id
    end

    if GroupTag.find_by_group_id_and_tag_id(@group.id, tag_id)==nil
      GroupTag.create(group_id: @group.id, tag_id: tag_id)
    end

    flash[:notice] = "Add Tag success" 
    redirect_to edit_group_path(@group)
  end

	private
	def set_group
    @group = Group.find_by_slug(params[:group_id])
  end
end
