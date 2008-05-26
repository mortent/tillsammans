class CreateTaxis < ActiveRecord::Migration
  def self.up
    create_table :taxis do |t|
      t.integer :event_id
      t.integer :location_id
      t.datetime :leaves_at
      t.integer :number_of_seats

      t.timestamps
    end
  end

  def self.down
    drop_table :taxis
  end
end
