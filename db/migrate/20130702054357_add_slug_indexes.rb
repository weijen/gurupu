class AddSlugIndexes < ActiveRecord::Migration
  def change
    add_index :expenses, :slug
    add_index :groups, :slug
    add_index :tags, :slug
  end
end
