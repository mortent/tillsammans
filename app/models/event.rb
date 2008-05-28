class Event < ActiveRecord::Base
  belongs_to :location
  has_many :attendances
  has_many :rides, :dependent => :destroy
  has_many :users, :through => :attendances
  
  def to_gmarker
    icon = GIcon.new(:image => '/images/ikon_event.png', :icon_size => GSize.new(24,32), 
            :icon_anchor => GPoint.new(16,16), :info_window_anchor => GPoint.new(16,16))     
    GMarker.new([location.lat, location.lng], :title => name, :icon => icon, 
            :info_window => "<b>#{name}</b><br/>#{description}<br>#{location.street}")  
  end   
   
  def self.load_events_from_pulic_bekk_calendar    
    User.find(:all).each do |user|
      username = user.mail_username
      password = user.mail_password
      host = 'hugin.bekk.no'
      ics = Bekkcal::Reader.bekk(host, username, password)
      if ics
        cal = Vpim::Icalendar.decode(ics).first.components do |ical_event|
          event = Event.new
                    
          next if ical_event.summary.nil? || ical_event.summary.strip == ""
          event.name = ical_event.summary 
          event.description = ical_event.description || ""
          event.starts_at = ical_event.dtstart
          event.ends_at = ical_event.dtend
          event.location = Location.find_by_name("BEKK") #event.location
          
          event.save
        end
      end
    end
  end
  
  def register_ride(user, number_of_seats)
    rides << ride = Ride.create!(:event => self, :location => user.location, :number_of_seats => number_of_seats)
    ride.add_passenger(user, true)
    ride
  end
  
  def cancel_ride_by_organizer(organizer) 
    keepers = []
    rides.each do |ride|
      if ride.organizer == organizer 
        ride.destroy 
      else
        keepers << ride
      end
    end
    self.rides = keepers
  end
  
  def get_ride_with_available_seats_for_location(location)
    rides.each do |ride|
      return ride if ride.location == location and ride.available_seats?
    end
    nil
  end
  
  # deprecated, ride should be fetched based on a user's location
  def get_ride_with_available_seats
    rides.each do |ride|
      return ride if ride.available_seats?
    end
    nil
  end

  # not recommended, add passengers directly to ride
  def register_passenger_to_available_ride(user)
    ride = get_ride_with_available_seats_for_location(user.location)
    ride.add_passenger(user) if ride
  end
  
  def ride_has_user?(user)
    rides.each do |ride|
      return true if ride.has_user?(user)
    end
    return false
  end
end
