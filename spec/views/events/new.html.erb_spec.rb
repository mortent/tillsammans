require File.dirname(__FILE__) + '/../../spec_helper'

describe "/events/new.html.erb" do
  include EventsHelper
  
  before(:each) do
    @event = mock_model(Event)
    @event.stub!(:new_record?).and_return(true)
    @event.stub!(:name).and_return("MyString")
    @event.stub!(:description).and_return("MyText")
    @event.stub!(:starts_at).and_return(Time.now)
    @event.stub!(:ends_at).and_return(Time.now)
    assigns[:event] = @event
  end

  it "should render new form" do
    render "/events/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", events_path) do
      with_tag("input#event_name[name=?]", "event[name]")
      with_tag("textarea#event_description[name=?]", "event[description]")
    end
  end
end


