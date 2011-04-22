class RemoveTitleFromCourses < ActiveRecord::Migration
  def self.up
    remove_column :courses, :title
  end

  def self.down
    add_column :courses, :title, :string
  end
end
