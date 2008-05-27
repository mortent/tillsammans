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
  
#  def ride_with_valid_attributes 
#    ride = Ride.new
#    ride.number_of_seats = @@test_number_of_seats
#    ride.event = Event.find(:all)[0]
#    ride.location = Location.find(:all)[0]
#    puts ride.number_of_seats
#    ride
#  end
  
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
    @ride.add_passenger(User.find(:all)[0], true)
    @ride.number_of_passengers.should == 1
    @ride.add_passenger(User.find(:all)[1], true)
    @ride.number_of_passengers.should == 2
  end
  
  it "should report number of available seats correctly" do
    @ride.attributes = valid_ride_attributes
    @ride.add_passenger(User.find(:all)[0], true)
    @ride.number_of_passengers.should == 1
    @ride.number_of_available_seats.should == @@test_number_of_seats-1
  end
  
  it "should report no available seats when filled up" do
    @ride.attributes = valid_ride_attributes
    @ride.number_of_seats = 1
    @ride.add_passenger(User.find(:all)[0], true)
    @ride.available_seats?.should_not == true
  end
  
  it "should have an organizer" do
    @ride.attributes = valid_ride_attributes
    users = User.find(:all)
    ordinary = users[0]
    organizer = users[1]
    @ride.add_passenger(ordinary, false)
    @ride.add_passenger(organizer, true)
    @ride.organizer.should_not == ordinary
    @ride.organizer.should == organizer
  end
end
