class AddMessageAndLocationTextToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :location_text, :string
    add_column :users, :message, :text
  end

  def self.down
    remove_column :users, :location_text
    remove_column :users, :message
  end
end
