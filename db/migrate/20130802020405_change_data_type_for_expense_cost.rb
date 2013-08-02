class ChangeDataTypeForExpenseCost < ActiveRecord::Migration
  def change
  	change_column :expenses, :cost, :decimal, precision: 18, scale: 2
  end
end
