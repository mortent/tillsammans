class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :name
      t.decimal :latitude
      t.decimal :longitude
      t.string :street
      t.string :zip
      t.string :city
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
