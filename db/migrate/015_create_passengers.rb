class CreatePassengers < ActiveRecord::Migration
  def self.up
    create_table :passengers do |t|
      t.integer :user_id
      t.integer :ride_id
      t.boolean :is_organizer, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :passengers
  end
end
