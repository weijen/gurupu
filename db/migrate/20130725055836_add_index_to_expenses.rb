class AddIndexToExpenses < ActiveRecord::Migration
  def change
  	add_index :expenses, [:date, :tag_id, :user_id]
  end
end
