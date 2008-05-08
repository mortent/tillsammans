class PublicController < ApplicationController
  
  # Show all events in map
  def index
    @map = Map.find_by_name('Oslo')
    @gmap = @map.to_gmap
    Event.find(:all).each { |e| @gmap.overlay_init(e.to_gmarker) }    
  end
  
  # Show all clients' office-locations in map
  def clients
    @map = Map.find_by_name('Stor-Oslo')    
    @gmap = @map.to_gmap
    Client.find(:all).each { |c| @gmap.overlay_init(c.to_gmarker) }    
  end
  
  # Show all users' locations in map
  def users
    @map = Map.find_by_name('Stor-Oslo')    
    @gmap = @map.to_gmap
    Users.find(:all).each { |u| @gmap.overlay_init(u.to_gmarker) }
  end
  
  # Show event and all users attending in the map, sorted by their location
  def event
    @map = Map.find_by_name('Oslo')
    @gmap = @map.to_gmap
    Event.find(params[:id], :include => ['users', 'clients']).each { |e| @gmap.overlay_init(e.to_gmarker) }    
  end
    
end
