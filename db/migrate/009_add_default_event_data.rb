class AddDefaultEventData < ActiveRecord::Migration
  def self.up
    e = Event.create(:name => 'Fagdag', :description => 'Fagdag på BEKK', :starts_at => Time.parse("2008/4/24 08:00"), :ends_at => Time.parse("2008/4/24 18:00")  )
    e.location = Location.find_by_name("BEKK")
    e.save!    
  end

  def self.down
    Event.delete_all
  end
end
