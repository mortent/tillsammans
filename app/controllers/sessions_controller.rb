# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController

  layout nil

  # render new.rhtml
  def new
  end

  def create
    self.current_user = User.authenticate(params[:login], params[:password])
    if logged_in?
      @user = self.current_user
      @locations = Location.find(:all)
      render :action => "login_successful"
    else
      @message = "Login failed"
      render :action => "login_failed"
    end
  end

  def destroy
    reset_session
    render :action => "logout_successful"
  end
end
