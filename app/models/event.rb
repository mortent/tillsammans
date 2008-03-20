class Event < ActiveRecord::Base
  belongs_to :location
  
  def to_gmarker
     GMarker.new([location.lat, location.lng], :title => name, :info_window => description)  
   end
end
