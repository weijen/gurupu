class ChangeDataTypeForDescription < ActiveRecord::Migration
  def up
    change_column :expenses, :description, :text
    change_column :groups, :description, :text
  end

  def down
    change_column :expenses, :description, :string
    change_column :groups, :description, :string
  end
end
