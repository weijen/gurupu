class AddRoleAndStateToGroupUsers < ActiveRecord::Migration
  def change
    add_column :group_users, :role, :string
    add_column :group_users, :state, :string
  end
end
