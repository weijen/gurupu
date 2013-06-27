class MoveIsDefaultFromGroupTagsToTags < ActiveRecord::Migration
  def up
    remove_column :group_tags, :is_default
    add_column :tags, :is_default, :boolean
  end

  def down
    add_column :group_tags, :is_default, :boolean
    remove_column :tags, :is_default
  end
end
