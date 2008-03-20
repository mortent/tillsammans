require File.dirname(__FILE__) + '/../spec_helper'

describe Location do
  before(:each) do
    @location = Location.new
  end

  it "should be valid" do
    @location.should be_valid
  end
  
  
    
  it "should set lat and lng if given" do
    @location.street = "Karl Johan 1"
    @location.city = "Oslo"
    
    @location.lng.should_not eql(nil)  
  end
end
