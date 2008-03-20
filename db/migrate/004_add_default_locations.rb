class AddDefaultLocations < ActiveRecord::Migration
  def self.up
    #location = Location.create(:name => "Skuret", :lat=> 59.901, :lng=> 10.735, :description => "Alle sjeler gleder seg, Hallelujah x 3!!")
    #Location.create(:name => "NAV", :lat=> 59.900, :lng=> 10.705, :description => "Hjem nr. 2. Ye Right :D")
    Location.create!(:name => 'BEKK', :street => 'Skur 39', :lat => 59.902756, :lng => 10.740396, :city => 'Oslo', :zip => '', :description => 'BEKKs hovedkontor')
    Location.create!(:name => 'NAV NDU', :street => 'Sannergata 2', :city => 'Oslo', :zip => '', :description => "Hjem nr. 2. Ye Right :D")    
  end

  def self.down
    Location.delete_all
  end
end
