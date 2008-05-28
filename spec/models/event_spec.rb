require File.dirname(__FILE__) + '/../spec_helper'


describe Event do
  fixtures :users, :locations
  
  before(:each) do
    @event = Event.new
  end

  it "should be valid" do
    @event.should be_valid
  end
  
  it "should register rides with an organizer" do
    organizer = User.find(1)
    organizer.location = Location.find(1)
    @event.register_ride(organizer, 4)
    @event.rides.size.should == 1
    @event.rides[0].organizer.should == organizer
  end
  
  it "should find a ride with available seats when it exists" do
    @event.rides.clear
    @event.register_ride(get_organizer, 1)
    @event.get_ride_with_available_seats.should == nil
    @event.register_ride(get_organizer(3), 2)
    @event.get_ride_with_available_seats.should_not == nil
  end
  
  it "should add passengers to a ride with available seats when it exists" do
    @event.register_ride(get_organizer, 4)
    ride = @event.get_ride_with_available_seats
    user = get_user(3)
    @event.register_passenger_to_available_ride(user)
    ride.number_of_passengers.should == 2
  end

  it "should find out if a user has already joined a ride" do
    organizer = get_organizer
    loner = get_user(3)
    @event.register_ride(organizer, 3)
    @event.ride_has_user?(organizer).should == true
    @event.ride_has_user?(loner).should_not == true
  end

  private
  
  def get_organizer(id=1)
    User.find(id)
  end
  
  def get_user(id)
    User.find(id)
  end
end
