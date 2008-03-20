class AddDefaultLocations < ActiveRecord::Migration
  def self.up
    location = Location.create(:name => "Skuret", :lat=> 59.901, :lng=> 10.735, :description => "Alle sjeler gleder seg, Hallelujah x 3!!")
    location.save!
    location = Location.create(:name => "NAV", :lat=> 59.900, :lng=> 10.705, :description => "Hjem nr. 2. Ye Right :D")
    location.save!
  end

  def self.down
    Location.delete_all
  end
end
