class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :sender_id
      t.integer :group_id
      t.string :email
      t.string :slug
    end

    add_index :invitations, :slug
  end
end
