class AddDescriptionAndDateAndGroupIdAndUserIdToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :description, :string
    add_column :expenses, :date, :datetime
    add_column :expenses, :group_id, :integer
    add_column :expenses, :user_id, :integer
  end
end
