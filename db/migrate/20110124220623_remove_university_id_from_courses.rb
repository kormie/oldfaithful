class RemoveUniversityIdFromCourses < ActiveRecord::Migration
  def self.up
    remove_column :courses, :university_id
  end

  def self.down
    add_column :courses, :university_id, :integer
  end
end
