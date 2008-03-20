require File.dirname(__FILE__) + '/../../spec_helper'

describe "/maps/index.html.erb" do
  include MapsHelper
  
  before(:each) do
    map_98 = mock_model(Map)
    map_98.should_receive(:name).and_return("MyString")
    map_98.should_receive(:description).and_return("MyText")
    map_98.should_receive(:lat).and_return("1.5")
    map_98.should_receive(:lng).and_return("1.5")
    map_98.should_receive(:zoom).and_return("1")
    map_99 = mock_model(Map)
    map_99.should_receive(:name).and_return("MyString")
    map_99.should_receive(:description).and_return("MyText")
    map_99.should_receive(:lat).and_return("1.5")
    map_99.should_receive(:lng).and_return("1.5")
    map_99.should_receive(:zoom).and_return("1")

    assigns[:maps] = [map_98, map_99]
  end

  it "should render list of maps" do
    render "/maps/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyText", 2)
    response.should have_tag("tr>td", "1.5", 2)
    response.should have_tag("tr>td", "1.5", 2)
    response.should have_tag("tr>td", "1", 2)
  end
end

