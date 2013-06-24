class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :description
      t.integer :owner_id
      t.string :slug

      t.timestamps
    end
  end
end
