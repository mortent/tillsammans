class UsersController < ApplicationController
  
  def index
    @users = Event.find(params[:event_id]).users

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end
  
  def update
    user = User.find(params[:id])
    location = Location.find(params[:user][:location_id])
    user.update_attributes(:location_id => params[:user][:location_id], :message => params[:user][:message], :location_text => location.name)
    if user.save
      self.current_user = user
      @message = "Vellyket lagring"
      render :action => "updated"
    else
      @message = "Lagring feilet"
      render :action => "updated"
    end
  end

end
