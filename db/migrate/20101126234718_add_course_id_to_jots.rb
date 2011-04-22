class AddCourseIdToJots < ActiveRecord::Migration
  def self.up
    add_column :jots, :course_id, :integer
  end

  def self.down
    remove_column :jots, :course_id
  end
end
