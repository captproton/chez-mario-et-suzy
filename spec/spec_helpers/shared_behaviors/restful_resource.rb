describe "a RESTfully routed resource", :shared => true do
  before(:each) do
    @rrr_path = restful_resource_path[:base_path]
    nested = restful_resource_path[:nested_params]
    nested ||= {}
    @default_route_params = { :controller => restful_resource_path[:controller] }.merge(nested)
  end

  describe "route generation" do

    it "should map index action to the base_path" do
      route_for(@default_route_params.merge(:action => "index")).should == @rrr_path
    end
  
    it "should map new action to base_path/new" do
      route_for(@default_route_params.merge(:action => "new")).should == "#{@rrr_path}/new"
    end
  
    it "should map show action with ID 1 to base_path/1" do
      route_for(@default_route_params.merge(:action => "show", :id => 1)).should == "#{@rrr_path}/1"
    end
  
    it "should map edit action with ID 1 to base_path/1/edit" do
      route_for(@default_route_params.merge(:action => "edit", :id => 1)).should == "#{@rrr_path}/1/edit"
    end
  
    it "should map update action with ID 1 to base_path/1" do
      route_for(@default_route_params.merge(:action => "update", :id => 1)).should == "#{@rrr_path}/1"
    end
  
    it "should map destroy action with ID 1 to base_path/1" do
      route_for(@default_route_params.merge(:action => "destroy", :id => 1)).should == "#{@rrr_path}/1"
    end
  end

  describe "route recognition" do

    it "should do index action on GET to base_path" do
      params_from(:get, @rrr_path).should == @default_route_params.merge(:action => "index")
    end
  
    it "should do new action on GET to base_path/new" do
      params_from(:get, "#{@rrr_path}/new").should == @default_route_params.merge(:action => "new")
    end
  
    it "should do create action on POST to base_path" do
      params_from(:post, @rrr_path).should == @default_route_params.merge(:action => "create")
    end
  
    it "should do show action with ID 1 on GET to base_path/1" do
      params_from(:get, "#{@rrr_path}/1").should == @default_route_params.merge(:action => "show", :id => "1")
    end
  
    it "should do edit action with ID 1 on GET to base_path/1/edit" do
      params_from(:get, "#{@rrr_path}/1/edit").should == @default_route_params.merge(:action => "edit", :id => "1")
    end
  
    it "should do update action with ID 1 on PUT to base_path/1" do
      params_from(:put, "#{@rrr_path}/1").should == @default_route_params.merge(:action => "update", :id => "1")
    end
  
    it "should destroy action with ID 1 on DELETE to base_path/1" do
      params_from(:delete, "#{@rrr_path}/1").should == @default_route_params.merge(:action => "destroy", :id => "1")
    end
  end
end
