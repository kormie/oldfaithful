class AddUniversityToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :university, :string
    add_column :users, :major, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
  end

  def self.down
    remove_column :users, :university
    remove_column :users, :major
    remove_column :users, :city
    remove_column :users, :state
  end
end
