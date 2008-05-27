require File.dirname(__FILE__) + '/../spec_helper'

describe Passenger do
  before(:each) do
    @passenger = Passenger.new
  end

  it "should be valid" do
    @passenger.should be_valid
  end
end
