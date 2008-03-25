class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :name
      t.text :description
      t.integer :location_id
      t.string :url
      t.string :image_url

      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
