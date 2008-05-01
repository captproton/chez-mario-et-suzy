describe "a default controller (without #show)", :shared => true do
  before(:all) do
    @singular_symbol = model_class.name.underscore.to_sym
    @plural_symbol = model_class.name.underscore.pluralize.to_sym
  end
  
  describe "handling GET to base_path" do
    before(:each) do
      @model = mock_model(model_class)
      model_class.stub!(:find).and_return([@model])
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
    
    it "should find all records" do
      model_class.should_receive(:find).with(:all).and_return([@model])
      do_get
    end
    
    it "should assign the found records for the view" do
      do_get
      assigns[@plural_symbol].should == [@model]
    end
  end
  
  describe "handling GET to base_path.xml" do
    before(:each) do
      @model = mock_model(model_class, :to_xml => "XML")
      model_class.stub!(:find).and_return(@model)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all records" do
      model_class.should_receive(:find).with(:all).and_return([@model])
      do_get
    end
  
    it "should render the found records as xml" do
      @model.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

=begin
  describe "handling GET to base_path/1" do
    before(:each) do
      @model = mock_model(model_class)
      model_class.stub!(:find).and_return(@model)
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
  
    it "should find the record requested" do
      model_class.should_receive(:find).with("1").and_return(@model)
      do_get
    end
  
    it "should assign the found record for the view" do
      do_get
      assigns[@singular_symbol].should equal(@model)
    end
  end
=end

  describe "handling GET to base_path/1.xml" do
    before(:each) do
      @model = mock_model(model_class, :to_xml => "XML")
      model_class.stub!(:find).and_return(@model)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the record requested" do
      model_class.should_receive(:find).with("1").and_return(@model)
      do_get
    end
  
    it "should render the found record as xml" do
      @model.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET to base_path/new" do
    before(:each) do
      @model = mock_model(model_class)
      model_class.stub!(:new).and_return(@model)
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
  
    it "should create a new record" do
      model_class.should_receive(:new).and_return(@model)
      do_get
    end
  
    it "should not save the new record" do
      @model.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new record for the view" do
      do_get
      assigns[@singular_symbol].should equal(@model)
    end
  end

  describe "handling GET to base_path/1/edit" do
    before(:each) do
      @model = mock_model(model_class)
      model_class.stub!(:find).and_return(@model)
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
  
    it "should find the record requested" do
      model_class.should_receive(:find).and_return(@model)
      do_get
    end
  
    it "should assign the found record for the view" do
      do_get
      assigns[@singular_symbol].should equal(@model)
    end
  end

  describe "handling POST to base_path" do
    before(:each) do
      @model = mock_model(model_class, :to_param => "1")
      model_class.stub!(:new).and_return(@model)
    end
    
    describe "with successful save" do
      def do_post
        @model.should_receive(:save).and_return(true)
        post :create, @singular_symbol => {}
      end
  
      it "should create a new record" do
        model_class.should_receive(:new).with({}).and_return(@model)
        do_post
      end

      it "should redirect to records list" do
        do_post
        response.should redirect_to(send!("#{model_class.name.underscore.pluralize}_url"))
      end
    end
    
    describe "with failed save" do
      def do_post
        @model.should_receive(:save).and_return(false)
        post :create, @singular_symbol => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
    end
  end

  describe "handling PUT to base_path/1" do
    before(:each) do
      @model = mock_model(model_class, :to_param => "1")
      model_class.stub!(:find).and_return(@model)
    end
    
    describe "with successful update" do
      def do_put
        @model.should_receive(:update_attributes).with({}).and_return(true)
        put :update, :id => "1", @singular_symbol => {}
      end

      it "should find the record requested" do
        model_class.should_receive(:find).with("1").and_return(@model)
        do_put
      end

      it "should assign the found record for the view" do
        do_put
        assigns(@singular_symbol).should equal(@model)
      end

      it "should redirect to records list" do
        do_put
        response.should redirect_to(send!("#{model_class.name.underscore.pluralize}_url"))
      end
    end
    
    describe "with failed update" do
      def do_put
        @model.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end
    end
  end

  describe "handling DELETE to base_path/1" do
    before(:each) do
      @model = mock_model(model_class, :destroy => true)
      model_class.stub!(:find).and_return(@model)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the record requested" do
      model_class.should_receive(:find).with("1").and_return(@model)
      do_delete
    end
  
    it "should call destroy on the found record" do
      @model.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the records list" do
      do_delete
      response.should redirect_to(send!("#{model_class.name.underscore.pluralize}_url"))
    end
  end
end
