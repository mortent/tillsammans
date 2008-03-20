require File.dirname(__FILE__) + '/../../spec_helper'

describe "/locations/show.html.erb" do
  include LocationsHelper
  
  before(:each) do
    @location = mock_model(Location)
    @location.stub!(:name).and_return("MyString")
    @location.stub!(:lat).and_return("9.99")
    @location.stub!(:lng).and_return("9.99")
    @location.stub!(:street).and_return("MyString")
    @location.stub!(:zip).and_return("MyString")
    @location.stub!(:city).and_return("MyString")
    @location.stub!(:description).and_return("MyText")

    assigns[:location] = @location
  end

  it "should render attributes in <p>" do
    render "/locations/show.html.erb"
    response.should have_text(/MyString/)
    response.should have_text(/9\.99/)
    response.should have_text(/9\.99/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyText/)
  end
end

