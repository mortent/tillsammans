class Location < ActiveRecord::Base
  #attr_accessor :latitude, :longitude, :name, :description
  
  def to_gmarker
    logger.debug("\nLatitude: #{@latitude}\nLongitude: #{@longitude}")
    GMarker.new([latitude, longitude], :title => name, :info_window => description)
    
  end
end
