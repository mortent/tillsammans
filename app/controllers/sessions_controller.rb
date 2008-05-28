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
      render :action => "login_successful"
    else
      @message = "Login failed"
      render :action => "login_failed"
    end
  end

  def destroy
    reset_session
    @message = "Logout successful"
    render :action => "logout_successful"
  end
end
