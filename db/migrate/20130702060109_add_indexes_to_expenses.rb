class AddIndexesToExpenses < ActiveRecord::Migration
  def change
    add_index :expenses, :user_id
    add_index :expenses, :group_id
  end
end
