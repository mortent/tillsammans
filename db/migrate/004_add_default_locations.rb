class AddDefaultLocations < ActiveRecord::Migration
  def self.up
    location = Location.create(:name => "Skuret", :latitude => 59.901, :longitude => 10.735, :description => "Alle sjeler gleder seg, Hallelujah x 3!!")
    location.save!
    location = Location.create(:name => "NAV", :latitude => 59.900, :longitude => 10.705, :description => "Hjem nr. 2. Ye Right :D")
    location.save!
  end

  def self.down
    Location.delete_all
  end
end
