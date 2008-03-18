class AddLocationToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :location_id, :integer, :default => 1
    # add_foreign_key :events, :location_id, :locations
  end

  def self.down
    # remove_foreign_key :events, :location_id
    remove_column :events, :location_id
  end
end
