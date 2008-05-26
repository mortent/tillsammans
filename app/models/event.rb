class Event < ActiveRecord::Base
  belongs_to :location
  has_many :attendances
  has_many :users, :through => :attendances
  
  def to_gmarker
    icon = GIcon.new(:image => '/images/ikon_event.png', :icon_size => GSize.new(24,32), 
            :icon_anchor => GPoint.new(16,16), :info_window_anchor => GPoint.new(16,16))     
    GMarker.new([location.lat, location.lng], :title => name, :icon => icon, 
            :info_window => "<b>#{name}</b><br/>#{description}<br>#{location.street}")  
  end   
   
  def self.load_events_from_bekk_calendar    
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
       
end
