class MapController < ApplicationController
  before_filter :setup
  
  def index    
  end
 
  def event
    @events = Events.find(:all)
  end

  def user
  end
  
  private
  
  def setup
    @map = GMap.new("bekkmap")
    @map.control_init(:large_map => true, :map_type => true)
    @map.center_zoom_init([59.92,10.749],12)    
    @map.overlay_init(GMarker.new([59.901,10.735], :title => "Skuret Hardkoda", :info_window => "Hardkoda info om skuret!"))
  end
end
