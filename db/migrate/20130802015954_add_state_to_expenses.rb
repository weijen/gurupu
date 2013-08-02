class AddStateToExpenses < ActiveRecord::Migration
  def change
  	add_column :expenses, :state, :string
  end
end
