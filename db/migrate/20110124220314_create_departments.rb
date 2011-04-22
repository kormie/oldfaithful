class CreateDepartments < ActiveRecord::Migration
  def self.up
    create_table :departments do |t|
      t.references :university
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :departments
  end
end
