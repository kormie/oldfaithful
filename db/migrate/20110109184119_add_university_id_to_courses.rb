class AddUniversityIdToCourses < ActiveRecord::Migration
  def self.up
    add_column :courses, :university_id, :integer
  end

  def self.down
    remove_column :courses, :university_id
  end
end
