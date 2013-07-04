class RemoveDescriptionFromExpenses < ActiveRecord::Migration
  def up
    remove_column :expenses, :description
  end

  def down
    add_column :expenses, :description, :string
  end
end
