class AddIndexToGroupUsers < ActiveRecord::Migration
  def change
    add_index :group_users, [:user_id, :group_id]
  end
end
