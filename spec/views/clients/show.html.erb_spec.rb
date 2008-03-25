require File.dirname(__FILE__) + '/../../spec_helper'

describe "/clients/show.html.erb" do
  include ClientsHelper
  
  before(:each) do
    @client = mock_model(Client)
    @client.stub!(:name).and_return("MyString")
    @client.stub!(:description).and_return("MyText")
    @client.stub!(:location_id).and_return("1")
    @client.stub!(:url).and_return("MyString")
    @client.stub!(:image_url).and_return("MyString")

    assigns[:client] = @client
  end

  it "should render attributes in <p>" do
    render "/clients/show.html.erb"
    response.should have_text(/MyString/)
    response.should have_text(/MyText/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
  end
end

