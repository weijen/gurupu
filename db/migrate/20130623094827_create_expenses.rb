class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :name
      t.integer :cost
      t.integer :tag_id
      t.string :slug

      t.timestamps
    end
  end
end
