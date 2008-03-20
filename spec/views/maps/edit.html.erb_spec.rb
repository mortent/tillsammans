require File.dirname(__FILE__) + '/../../spec_helper'

describe "/maps/edit.html.erb" do
  include MapsHelper
  
  before do
    @map = mock_model(Map)
    @map.stub!(:name).and_return("MyString")
    @map.stub!(:description).and_return("MyText")
    @map.stub!(:lat).and_return("1.5")
    @map.stub!(:lng).and_return("1.5")
    @map.stub!(:zoom).and_return("1")
    assigns[:map] = @map
  end

  it "should render edit form" do
    render "/maps/edit.html.erb"
    
    response.should have_tag("form[action=#{map_path(@map)}][method=post]") do
      with_tag('input#map_name[name=?]', "map[name]")
      with_tag('textarea#map_description[name=?]', "map[description]")
      with_tag('input#map_lat[name=?]', "map[lat]")
      with_tag('input#map_lng[name=?]', "map[lng]")
      with_tag('input#map_zoom[name=?]', "map[zoom]")
    end
  end
end


