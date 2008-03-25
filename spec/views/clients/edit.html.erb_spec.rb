require File.dirname(__FILE__) + '/../../spec_helper'

describe "/clients/edit.html.erb" do
  include ClientsHelper
  
  before do
    @client = mock_model(Client)
    @client.stub!(:name).and_return("MyString")
    @client.stub!(:description).and_return("MyText")
    @client.stub!(:location_id).and_return("1")
    @client.stub!(:url).and_return("MyString")
    @client.stub!(:image_url).and_return("MyString")
    assigns[:client] = @client
  end

  it "should render edit form" do
    render "/clients/edit.html.erb"
    
    response.should have_tag("form[action=#{client_path(@client)}][method=post]") do
      with_tag('input#client_name[name=?]', "client[name]")
      with_tag('textarea#client_description[name=?]', "client[description]")
      with_tag('input#client_url[name=?]', "client[url]")
      with_tag('input#client_image_url[name=?]', "client[image_url]")
    end
  end
end


