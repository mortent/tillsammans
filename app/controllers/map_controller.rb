class MapController < ApplicationController

  #require 'ym4r'
  #include Ym4r::GoogleMaps
  
  def index
    @map = GMap.new("bekkmap")
    @map.control_init(:large_map => true, :map_type => true)
    @map.center_zoom_init([59.92,10.749],12)    
    @map.overlay_init(GMarker.new([59.901,10.735], :title => "Skuret Hardkoda", :info_window => "Hardkoda info om skuret!"))
  end
 
  def event
  end

  def user
  end
end
