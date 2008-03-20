class PublicController < ApplicationController  
  def index
    @map = Map.find_by_name('Oslo')
    @gmap = @map.to_gmap
    
    #locations = Location.find(:all)
    
    #locations.each do |l| 
    #	@gmap.overlay_init(l.to_gmarker)
    #end
    
    events = Event.find(:all)
    
    events.each do |e|
      @gmap.overlay_init(e.to_gmarker)
    end
  end
end
