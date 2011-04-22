class AddProfessorAndTermToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :professor, :string
    add_column :courses, :term, :string
  end

  def self.down
    remove_column :courses, :term
    remove_column :courses, :professor
  end
end
