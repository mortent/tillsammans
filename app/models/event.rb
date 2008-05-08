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
   
end
