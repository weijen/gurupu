class AddIsDefaultToGroupTags < ActiveRecord::Migration
  def change
    add_column :group_tags, :is_default, :boolean
  end
end
