class RemoveUniversityFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :university
  end

  def self.down
    add_column :users, :university, :string
  end
end
