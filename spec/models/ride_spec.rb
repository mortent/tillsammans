require File.dirname(__FILE__) + '/../spec_helper'

describe Ride do
  fixtures :locations, :events, :users
  
  @@test_number_of_seats = 4
  def valid_ride_attributes
    {
      :number_of_seats => @@test_number_of_seats,
      :event => Event.find(:all)[0],
      :location => Location.find(:all)[0]
    }
  end
    
  def get_user(id)
    User.find(id)
  end
  
  before(:each) do
    @ride = Ride.new
  end
  
  it "should be valid when fields are set" do
    @ride.attributes = valid_ride_attributes
    @ride.should be_valid
  end

  it "should not be valid with no fields set" do
    @ride.should_not be_valid
  end
  
  it "should not be valid if number of seats isn't set to an integer" do
    @ride.attributes = valid_ride_attributes.except(:number_of_seats)
    @ride.number_of_seats = "Not a number"
    @ride.should_not be_valid
  end
  
  it "should register passengers" do
    @ride.attributes = valid_ride_attributes
    @ride.add_passenger(get_user(1), true)
    @ride.add_passenger(get_user(2), true)
    @ride.number_of_passengers.should == 2
  end
  
  it "should report number of available seats correctly" do
    @ride.attributes = valid_ride_attributes
    @ride.add_passenger(get_user(2), true)
    @ride.number_of_passengers.should == 1
    @ride.number_of_available_seats.should == @@test_number_of_seats-1
  end
  
  it "should report no available seats when filled up" do
    @ride.attributes = valid_ride_attributes
    @ride.number_of_seats = 1
    @ride.add_passenger(get_user(1), false)
    @ride.available_seats?.should_not == true
  end
  
  it "should have an organizer" do
    @ride.attributes = valid_ride_attributes
    ordinary = get_user(1)
    organizer = get_user(2)
    @ride.add_passenger(ordinary, false)
    @ride.add_passenger(organizer, true)
    @ride.organizer.should_not == ordinary
    @ride.organizer.should == organizer
  end
  
  it "should not be possible to add too many passengers" do
    @ride.attributes = valid_ride_attributes
    @ride.number_of_seats = 2
    @ride.add_passenger(get_user(1), true)
    @ride.add_passenger(get_user(2), false)
    @ride.add_passenger(get_user(3), false)
    @ride.number_of_passengers.should == 2
    @ride.number_of_available_seats.should_not < 0
  end
  
  it "should report if a user is getting a ride" do
    @ride.attributes = valid_ride_attributes
    user = get_user(1)
    @ride.add_passenger(get_user(2), true)
    @ride.add_passenger(user, false)
    @ride.add_passenger(get_user(3), false)
    @ride.has_user?(user).should == true
    loner = get_user(4)
    @ride.has_user?(loner).should_not == true
  end
  
  it "should remove requested passengers when requested" do 
    @ride.attributes = valid_ride_attributes
    user = get_user(1)
    @ride.add_passenger(get_user(2), true)
    @ride.add_passenger(user)
    @ride.number_of_passengers.should == 2
    @ride.remove_passenger(user)
    @ride.number_of_passengers.should == 1
  end
  
  it "should remove all passengers when and destroy ride when organizer is removed" do
    @ride.attributes = valid_ride_attributes
    organizer = get_user(1)
    @ride.add_passenger(organizer, true)
    @ride.add_passenger(get_user(2))
    @ride.add_passenger(get_user(3))
    @ride.number_of_passengers.should == 3
    @ride.remove_passenger(organizer).should == nil
    # sets passengers to zero, but in reality the record should be deleted from the database
    @ride.number_of_passengers.should == 0
  end
end
