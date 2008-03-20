class CreateMaps < ActiveRecord::Migration
  def self.up
    create_table :maps do |t|
      t.string :name
      t.text :description
      t.float :lat
      t.float :lng
      t.integer :zoom

      t.timestamps
    end
  end

  def self.down
    drop_table :maps
  end
end
