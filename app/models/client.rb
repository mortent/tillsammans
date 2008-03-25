class Client < ActiveRecord::Base
  belongs_to :location
  
  def to_gmarker
     icon = GIcon.new(:image => '/images/buddha_small_icon.png', :icon_size => GSize.new( 24,32 ), :icon_anchor => GPoint.new(16,16), :info_window_anchor => GPoint.new(16,16))     
     GMarker.new([location.lat, location.lng], :title => name, :icon => icon, :info_window => "<b>#{name}</b><br/>#{description}<br>#{location.street}")  
  end   
end
