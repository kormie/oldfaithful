class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table :courses do |t|
      t.string :title
      t.integer :number
      t.integer :department_id
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :courses
  end
end
