class CreateJots < ActiveRecord::Migration
  def self.up
    create_table :jots do |t|
      t.string :title
      t.text :content
      t.boolean :visibility

      t.timestamps
    end
  end

  def self.down
    drop_table :jots
  end
end
