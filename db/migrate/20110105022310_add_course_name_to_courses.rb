class AddCourseNameToCourses < ActiveRecord::Migration
  def self.up
    add_column :courses, :name, :string
  end

  def self.down
    remove_column :courses, :name
  end
end
