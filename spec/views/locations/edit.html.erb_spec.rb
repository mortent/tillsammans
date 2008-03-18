require File.dirname(__FILE__) + '/../../spec_helper'

describe "/locations/edit.html.erb" do
  include LocationsHelper
  
  before do
    @location = mock_model(Location)
    @location.stub!(:name).and_return("MyString")
    @location.stub!(:latitude).and_return("9.99")
    @location.stub!(:longitude).and_return("9.99")
    @location.stub!(:street).and_return("MyString")
    @location.stub!(:zip).and_return("MyString")
    @location.stub!(:city).and_return("MyString")
    @location.stub!(:description).and_return("MyText")
    assigns[:location] = @location
  end

  it "should render edit form" do
    render "/locations/edit.html.erb"
    
    response.should have_tag("form[action=#{location_path(@location)}][method=post]") do
      with_tag('input#location_name[name=?]', "location[name]")
      with_tag('input#location_latitude[name=?]', "location[latitude]")
      with_tag('input#location_longitude[name=?]', "location[longitude]")
      with_tag('input#location_street[name=?]', "location[street]")
      with_tag('input#location_zip[name=?]', "location[zip]")
      with_tag('input#location_city[name=?]', "location[city]")
      with_tag('textarea#location_description[name=?]', "location[description]")
    end
  end
end


