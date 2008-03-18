require File.dirname(__FILE__) + '/../../spec_helper'

describe "/events/edit.html.erb" do
  include EventsHelper
  
  before do
    @event = mock_model(Event)
    @event.stub!(:name).and_return("MyString")
    @event.stub!(:description).and_return("MyText")
    @event.stub!(:starts_at).and_return(Time.now)
    @event.stub!(:ends_at).and_return(Time.now)
    assigns[:event] = @event
  end

  it "should render edit form" do
    render "/events/edit.html.erb"
    
    response.should have_tag("form[action=#{event_path(@event)}][method=post]") do
      with_tag('input#event_name[name=?]', "event[name]")
      with_tag('textarea#event_description[name=?]', "event[description]")
    end
  end
end


