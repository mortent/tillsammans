class PublicController < ApplicationController
  
  # Show all events in map
  def index
    @user = self.current_user
    @locations = Location.find(:all)
    @map = Map.find_by_name('Oslo')
    @gmap = @map.to_gmap
    Event.find(:all).each { |e| @gmap.overlay_init(e.to_gmarker) }    
  end
  
  # Show all clients' office-locations in map
  def clients
    @map = Map.find_by_name('Stor-Oslo')    
    @gmap = @map.to_gmap
    Client.find(:all).each { |c| @gmap.overlay_init(c.to_gmarker) }
    render :action => :index
  end
  
  # Show all users' locations in map
  def users
    @map = Map.find_by_name('Stor-Oslo')    
    @gmap = @map.to_gmap
    Users.find(:all).each { |u| @gmap.overlay_init(u.to_gmarker) }
    render :action => :index
  end
  
  # Show event and all users attending in the map, sorted by their location
  def event
    @map = Map.find_by_name('Oslo')
    @gmap = @map.to_gmap
    event = Event.find(params[:id], :include => ['users'])
    event.users.each { |u| @gmap.overlay_init(u.to_gmarker) }    
    render :action => :index
  end
    
end
