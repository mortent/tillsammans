require File.dirname(__FILE__) + '/../spec_helper'

describe MapsController do
  describe "route generation" do

    it "should map { :controller => 'maps', :action => 'index' } to /maps" do
      route_for(:controller => "maps", :action => "index").should == "/maps"
    end
  
    it "should map { :controller => 'maps', :action => 'new' } to /maps/new" do
      route_for(:controller => "maps", :action => "new").should == "/maps/new"
    end
  
    it "should map { :controller => 'maps', :action => 'show', :id => 1 } to /maps/1" do
      route_for(:controller => "maps", :action => "show", :id => 1).should == "/maps/1"
    end
  
    it "should map { :controller => 'maps', :action => 'edit', :id => 1 } to /maps/1/edit" do
      route_for(:controller => "maps", :action => "edit", :id => 1).should == "/maps/1/edit"
    end
  
    it "should map { :controller => 'maps', :action => 'update', :id => 1} to /maps/1" do
      route_for(:controller => "maps", :action => "update", :id => 1).should == "/maps/1"
    end
  
    it "should map { :controller => 'maps', :action => 'destroy', :id => 1} to /maps/1" do
      route_for(:controller => "maps", :action => "destroy", :id => 1).should == "/maps/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'maps', action => 'index' } from GET /maps" do
      params_from(:get, "/maps").should == {:controller => "maps", :action => "index"}
    end
  
    it "should generate params { :controller => 'maps', action => 'new' } from GET /maps/new" do
      params_from(:get, "/maps/new").should == {:controller => "maps", :action => "new"}
    end
  
    it "should generate params { :controller => 'maps', action => 'create' } from POST /maps" do
      params_from(:post, "/maps").should == {:controller => "maps", :action => "create"}
    end
  
    it "should generate params { :controller => 'maps', action => 'show', id => '1' } from GET /maps/1" do
      params_from(:get, "/maps/1").should == {:controller => "maps", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'maps', action => 'edit', id => '1' } from GET /maps/1;edit" do
      params_from(:get, "/maps/1/edit").should == {:controller => "maps", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'maps', action => 'update', id => '1' } from PUT /maps/1" do
      params_from(:put, "/maps/1").should == {:controller => "maps", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'maps', action => 'destroy', id => '1' } from DELETE /maps/1" do
      params_from(:delete, "/maps/1").should == {:controller => "maps", :action => "destroy", :id => "1"}
    end
  end
end