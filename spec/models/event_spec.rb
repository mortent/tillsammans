require File.dirname(__FILE__) + '/../spec_helper'

describe Event do
  fixtures :locations, :events

   def get_event(id)
     Event.find(:all)[id]
   end

  before(:each) do
    @event = Event.new
  end

  it "should have a gmarker" do
    @event.to_gmarker.should_not be_nil
  end
end
