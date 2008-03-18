require File.dirname(__FILE__) + '/../spec_helper'

describe MapController do

  #Delete these examples and add some real ones
  it "should use MapController" do
    controller.should be_an_instance_of(MapController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'event'" do
    it "should be successful" do
      get 'event'
      response.should be_success
    end
  end

  describe "GET 'user'" do
    it "should be successful" do
      get 'user'
      response.should be_success
    end
  end
end
