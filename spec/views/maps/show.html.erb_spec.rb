require File.dirname(__FILE__) + '/../../spec_helper'

describe "/maps/show.html.erb" do
  include MapsHelper
  
  before(:each) do
    @map = mock_model(Map)
    @map.stub!(:name).and_return("MyString")
    @map.stub!(:description).and_return("MyText")
    @map.stub!(:lat).and_return("1.5")
    @map.stub!(:lng).and_return("1.5")
    @map.stub!(:zoom).and_return("1")

    assigns[:map] = @map
  end

  it "should render attributes in <p>" do
    render "/maps/show.html.erb"
    response.should have_text(/MyString/)
    response.should have_text(/MyText/)
    response.should have_text(/1\.5/)
    response.should have_text(/1\.5/)
    response.should have_text(/1/)
  end
end

