require File.dirname(__FILE__) + '/../spec_helper'

describe Map do
  before(:each) do
    @map = Map.new
  end

  it "should be valid" do
    @map.should be_valid
  end
end
