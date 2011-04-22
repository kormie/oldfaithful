class AddUniversityIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :university_id, :integer
  end

  def self.down
    remove_column :users, :university_id
  end
end
