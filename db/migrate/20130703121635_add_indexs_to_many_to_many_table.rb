class AddIndexsToManyToManyTable < ActiveRecord::Migration
  def change
    add_index :group_tags, :group_id
    add_index :group_tags, :tag_id

    add_index :group_users, :group_id
    add_index :group_users, :user_id
  end
end
