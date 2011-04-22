class CreateJotsUsersJoin < ActiveRecord::Migration
  def self.up
    create_table :jots_users, :id => false do |t|
      t.integer "jot_id"
      t.integer "user_id"
    end
    add_index :jots_users, ["jot_id", "user_id"]
  end

  def self.down
    drop_table :jots_users
  end
end
