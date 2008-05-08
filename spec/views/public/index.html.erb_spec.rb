require File.dirname(__FILE__) + '/../../spec_helper'

describe "/public/index" do
  it "should show a div with id map (google map)" do
    map = mock_model(Map)
    gmap = map.stub!(:to_gmap)
    gmap.should_receive(:to_html).and_return("gmap!")  
    assigns[:gmap] = gmap
    render "/public/index"    
    response.should have_tag('div#map')
  end
end
