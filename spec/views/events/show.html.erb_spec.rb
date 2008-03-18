require File.dirname(__FILE__) + '/../../spec_helper'

describe "/events/show.html.erb" do
  include EventsHelper
  
  before(:each) do
    @event = mock_model(Event)
    @event.stub!(:name).and_return("MyString")
    @event.stub!(:description).and_return("MyText")
    @event.stub!(:starts_at).and_return(Time.now)
    @event.stub!(:ends_at).and_return(Time.now)

    assigns[:event] = @event
  end

  it "should render attributes in <p>" do
    render "/events/show.html.erb"
    response.should have_text(/MyString/)
    response.should have_text(/MyText/)
  end
end

