require File.dirname(__FILE__) + '/../spec_helper'

describe MapsController do
  describe "handling GET /maps" do

    before(:each) do
      @map = mock_model(Map)
      Map.stub!(:find).and_return([@map])
    end
  
    def do_get
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render index template" do
      do_get
      response.should render_template('index')
    end
  
    it "should find all maps" do
      Map.should_receive(:find).with(:all).and_return([@map])
      do_get
    end
  
    it "should assign the found maps for the view" do
      do_get
      assigns[:maps].should == [@map]
    end
  end

  describe "handling GET /maps.xml" do

    before(:each) do
      @map = mock_model(Map, :to_xml => "XML")
      Map.stub!(:find).and_return(@map)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all maps" do
      Map.should_receive(:find).with(:all).and_return([@map])
      do_get
    end
  
    it "should render the found maps as xml" do
      @map.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /maps/1" do

    before(:each) do
      @map = mock_model(Map)
      Map.stub!(:find).and_return(@map)
    end
  
    def do_get
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render show template" do
      do_get
      response.should render_template('show')
    end
  
    it "should find the map requested" do
      Map.should_receive(:find).with("1").and_return(@map)
      do_get
    end
  
    it "should assign the found map for the view" do
      do_get
      assigns[:map].should equal(@map)
    end
  end

  describe "handling GET /maps/1.xml" do

    before(:each) do
      @map = mock_model(Map, :to_xml => "XML")
      Map.stub!(:find).and_return(@map)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the map requested" do
      Map.should_receive(:find).with("1").and_return(@map)
      do_get
    end
  
    it "should render the found map as xml" do
      @map.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /maps/new" do

    before(:each) do
      @map = mock_model(Map)
      Map.stub!(:new).and_return(@map)
    end
  
    def do_get
      get :new
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render new template" do
      do_get
      response.should render_template('new')
    end
  
    it "should create an new map" do
      Map.should_receive(:new).and_return(@map)
      do_get
    end
  
    it "should not save the new map" do
      @map.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new map for the view" do
      do_get
      assigns[:map].should equal(@map)
    end
  end

  describe "handling GET /maps/1/edit" do

    before(:each) do
      @map = mock_model(Map)
      Map.stub!(:find).and_return(@map)
    end
  
    def do_get
      get :edit, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render edit template" do
      do_get
      response.should render_template('edit')
    end
  
    it "should find the map requested" do
      Map.should_receive(:find).and_return(@map)
      do_get
    end
  
    it "should assign the found Map for the view" do
      do_get
      assigns[:map].should equal(@map)
    end
  end

  describe "handling POST /maps" do

    before(:each) do
      @map = mock_model(Map, :to_param => "1")
      Map.stub!(:new).and_return(@map)
    end
    
    describe "with successful save" do
  
      def do_post
        @map.should_receive(:save).and_return(true)
        post :create, :map => {}
      end
  
      it "should create a new map" do
        Map.should_receive(:new).with({}).and_return(@map)
        do_post
      end

      it "should redirect to the new map" do
        do_post
        response.should redirect_to(map_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @map.should_receive(:save).and_return(false)
        post :create, :map => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /maps/1" do

    before(:each) do
      @map = mock_model(Map, :to_param => "1")
      Map.stub!(:find).and_return(@map)
    end
    
    describe "with successful update" do

      def do_put
        @map.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the map requested" do
        Map.should_receive(:find).with("1").and_return(@map)
        do_put
      end

      it "should update the found map" do
        do_put
        assigns(:map).should equal(@map)
      end

      it "should assign the found map for the view" do
        do_put
        assigns(:map).should equal(@map)
      end

      it "should redirect to the map" do
        do_put
        response.should redirect_to(map_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @map.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /maps/1" do

    before(:each) do
      @map = mock_model(Map, :destroy => true)
      Map.stub!(:find).and_return(@map)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the map requested" do
      Map.should_receive(:find).with("1").and_return(@map)
      do_delete
    end
  
    it "should call destroy on the found map" do
      @map.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the maps list" do
      do_delete
      response.should redirect_to(maps_url)
    end
  end
end