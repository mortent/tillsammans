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
    user.update_attributes(:location_id => params[:user][:location_id], :message => params[:user][:message])
    if user.save
      self.current_user = user
      render :text => "user updated" 
    else
      render :text => "user update failed"
    end
  end

end
