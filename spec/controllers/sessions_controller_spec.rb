require File.dirname(__FILE__) + '/../spec_helper'

# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead
# Then, you can remove it from this and the units test.
include AuthenticatedTestHelper

describe SessionsController do
  fixtures :users

#  it 'logins and redirects' do
#    post :create, :login => 'quentin', :password => 'test'
#    session[:user_id].should_not be_nil
#    response.should be_success
#  end
  
  it 'fails login and does not redirect' do
    post :create, :login => 'quentin', :password => 'bad password'
    session[:user_id].should be_nil
    response.should be_success
  end

  it 'logs out' do
    login_as :quentin
    get :destroy
    session[:user_id].should be_nil
    response.should be_success
  end

  def auth_token(token)
    CGI::Cookie.new('name' => 'auth_token', 'value' => token)
  end
    
  def cookie_for(user)
    auth_token users(user).remember_token
  end
end
