class Location < ActiveRecord::Base
  @@country = 'Norway'
  
  acts_as_mappable
  before_validation_on_create :geocode_street_city

  def to_gmarker
    logger.debug("\nLatitude: #{lat}\nLongitude: #{lng}")
    GMarker.new([lat, lng], :title => name, :info_window => description)  
  end

  # PRIVATE!
  
  private  
  
  def geocode_street_city    
    geo = GeoKit::Geocoders::MultiGeocoder.geocode("#{street}, #{city}, #{@@country}")
    if geo.success
      self.lat, self.lng = geo.lat, geo.lng
    else
      errors.add(:street, "Could not Geocode street")
      errors.add(:city, "Could not Geocode city")
    end
  end
end
