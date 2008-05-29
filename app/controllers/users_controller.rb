class UsersController < ApplicationController
  
  def update
    user = User.find(params[:id])
    user.update_attributes(:location_text => params[:user][:location_text], :message => params[:user][:message])
    if user.save
      self.current_user = user
      render :text => "user updated" 
    else
      render :text => "user update failed"
    end
  end

end
