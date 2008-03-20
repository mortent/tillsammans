class AddDefaultMapData < ActiveRecord::Migration
  def self.up
    Map.create!(:name => 'Oslo', :description => 'Oslo sentrum...', :lat => 59.92, :lng => 10.749, :zoom => 12)
    Map.create!(:name => 'Stor-Oslo', :description => 'Kartutsnitt som viser alle prosjektplasser i og rundt Oslo', :lat => 59.92, :lng => 10.749, :zoom => 10)
  end

  def self.down
    Map.delete_all
  end
end
