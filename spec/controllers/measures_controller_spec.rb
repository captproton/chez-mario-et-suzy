require File.dirname(__FILE__) + '/../spec_helper'

describe "find requested recipe category and recipe", :shared => true do
  it "should find the requested recipe category" do
    RecipeCategory.should_receive(:find).with("30").and_return(@recipe_category)
    call_request
  end
  
  it "should find the requested recipe" do
    Recipe.should_receive(:find).with("22").and_return(@recipe)
    call_request
  end
end

describe "find all ingredients and assign them for the view", :shared => true do
  it "should find all ingredients" do
    Ingredient.should_receive(:find).with(:all).and_return([@ingredient])
    call_request
  end
  
  it "should assign found ingredients for the view" do
    call_request
    assigns[:ingredients].should == [@ingredient]
  end
end

describe MeasuresController do
  include MeasureSpecHelper
  
  def init_parent_model_mocks
    @recipe_category = mock_model(RecipeCategory, :to_param => "30")
    RecipeCategory.stub!(:find).and_return(@recipe_category)
    @recipe = mock_model(Recipe, :to_param => "22")
    Recipe.stub!(:find).and_return(@recipe)
  end
  
  def parent_model_params
    { :recipe_category_id => "30", :recipe_id => "22" }
  end
  
  def init_ingredient_mocks
    @ingredient = mock_model(Ingredient)
    Ingredient.stub!(:find).and_return([@ingredient])
  end
  
  it_should_behave_like "a RESTfully routed resource"
  
  describe "handling GET to /recipe_categories/30/recipes/22/measures" do
    before(:each) do
      @measure = mock_model(Measure)
      init_parent_model_mocks
      @recipe.stub!(:measures).and_return([@measure])
    end
    
    def do_get
      get :index, parent_model_params
    end
    
    it "should be successful" do
      do_get
      response.should be_success
    end
    
    it "should render index template" do
      do_get
      response.should render_template('index')
    end
    
    def call_request; do_get; end
    it_should_behave_like "find requested recipe category and recipe"
    
    it "should find all associated measures" do
      @recipe.should_receive(:measures).and_return([@measure])
      do_get
    end
    
    it "should assign the found measures for the view" do
      do_get
      assigns[:measures].should == [@measure]
    end
  end
  
  describe "handling GET to /recipe_categories/30/recipes/22/measures.xml" do
    before(:each) do
      @measure = mock_model(Measure)
      init_parent_model_mocks
      @measures = Array.new
      @measures << @measure
      @measures.stub!(:to_xml).and_return("XML")
      @recipe.stub!(:measures).and_return(@measures)
    end
    
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index, parent_model_params
    end
    
    it "should find all associated measures" do
      @recipe.should_receive(:measures).and_return(@measure)
      do_get
    end
    
    def call_request; do_get; end
    it_should_behave_like "find requested recipe category and recipe"
    
    it "should render the found measures as xml" do
      @measures.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end
  
  describe "handling GET to /recipe_categories/30/recipes/22/measures/1.xml" do
    before(:each) do
      @measure = mock_model(Measure, :to_xml => "XML")
      Measure.stub!(:find).and_return(@measure)
      init_parent_model_mocks
    end
    
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, parent_model_params.merge(:id => "1")
    end
    
    it "should be successful" do
      do_get
      response.should be_success
    end
    
    it "should find the requested measure" do
      Measure.should_receive(:find).with("1").and_return(@measure)
      do_get
    end
    
    it "should render the found measure as xml" do
      @measure.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end
  
  describe "handling GET to /recipe_categories/30/recipes/22/measures/new" do
    before(:each) do
      @measure = mock_model(Measure, :null_object => true)
      Measure.stub!(:new).and_return(@measure)
      init_parent_model_mocks
      init_ingredient_mocks
    end
    
    def do_get
      get :new, parent_model_params
    end
    
    it "should be successful" do
      do_get
      response.should be_success
    end
    
    it "should render new template" do
      do_get
      response.should render_template('new')
    end
    
    def call_request; do_get; end
    it_should_behave_like "find requested recipe category and recipe"
    it_should_behave_like "find all ingredients and assign them for the view"
    
    it "should create the new record" do
      Measure.should_receive(:new).and_return(@measure)
      do_get
    end
    
    it "should set the recipe for the newly created measure" do
      @measure.should_receive(:recipe=).with(@recipe)
      do_get
    end
    
    it "should not save the new measure" do
      @measure.should_not_receive(:save)
      do_get
    end
    
    it "should assign the new record for the view" do
      do_get
      assigns[:measure].should == @measure
    end
  end
  
  describe "handling GET to /recipe_categories/30/recipes/22/measures/1/edit" do
    before(:each) do
      @measure = mock_model(Measure)
      Measure.stub!(:find).and_return(@measure)
      init_parent_model_mocks
      init_ingredient_mocks
    end
    
    def do_get
      get :edit, parent_model_params.merge(:id => "1")
    end
    
    it "should be successful" do
      do_get
      response.should be_success
    end
    
    it "should render edit template" do
      do_get
      response.should render_template('edit')
    end
    
    def call_request; do_get; end
    it_should_behave_like "find requested recipe category and recipe"
    it_should_behave_like "find all ingredients and assign them for the view"
    
    it "should fnd the requested measure" do
      Measure.should_receive(:find).with("1").and_return(@measure)
      do_get
    end
    
    it "should assign the found measure for the view" do
      do_get
      assigns[:measure].should == @measure
    end
  end
  
  describe "handling POST to /recipe_categories/30/recipes/22/measures" do
    before(:each) do
      @measure = mock_model(Measure, :null_object => true)
      Measure.stub!(:new).and_return(@measure)
      init_parent_model_mocks
    end
    
    describe "with successful save" do
      def call_request
        @measure.should_receive(:save).and_return(true)
        post :create, parent_model_params.merge(:measure => {})
      end
  
      it "should create a new measure" do
        Measure.should_receive(:new).with({}).and_return(@measure)
        call_request
      end
      
      it "should set the recipe for the newly created measure" do
        @measure.should_receive(:recipe=).with(@recipe)
        call_request
      end

      it "should redirect to the recipe page" do
        @recipe_category.should_receive(:to_param).at_least(:once).and_return("30")
        @recipe.should_receive(:to_param).at_least(:once).and_return("22")
        call_request
        response.should redirect_to(recipe_category_recipe_url(@recipe_category, @recipe))
      end
    end
    
    describe "with failed save" do
      def call_request
        @measure.should_receive(:save).and_return(false)
        post :create, parent_model_params.merge(:measure => {})
      end
  
      it "should re-render 'new'" do
        call_request
        response.should render_template('new')
      end
    end
  end
  
  describe "handling PUT to /recipe_categories/30/recipes/22/measures/1" do
    before(:each) do
      @measure = mock_model(Measure, :to_param => "1", :null_object => true)
      Measure.stub!(:find).and_return(@measure)
      init_parent_model_mocks
    end
    
    describe "with successful update" do
      def call_request
        put :update, parent_model_params.merge(:id => "1", :measure => {})
      end

      it "should find the requested measure" do
        Measure.should_receive(:find).with("1").and_return(@measure)
        call_request
      end
      
      it "should update the found measure" do
        @measure.should_receive(:update_attributes).with({}).and_return(true)
        call_request
      end

      it "should redirect to the recipe page" do
        @recipe_category.should_receive(:to_param).at_least(:once).and_return("30")
        @recipe.should_receive(:to_param).at_least(:once).and_return("22")
        call_request
        response.should redirect_to(recipe_category_recipe_url(@recipe_category, @recipe))
      end
    end
    
    describe "with failed update" do
      def call_request
        @measure.should_receive(:update_attributes).and_return(false)
        put :update, parent_model_params.merge(:id => "1", :measure => {})
      end

      it "should re-render 'edit'" do
        call_request
        response.should render_template('edit')
      end
    end
  end
  
  describe "handling DELETE to /recipe_categories/30/recipes/22/measures/1" do
    before(:each) do
      @measure = mock_model(Measure, :destroy => true, :null_object => true)
      Measure.stub!(:find).and_return(@measure)
      init_parent_model_mocks
    end
  
    def call_request
      delete :destroy, parent_model_params.merge(:id => "1")
    end

    it "should find the requested measure" do
      Measure.should_receive(:find).with("1").and_return(@measure)
      call_request
    end
  
    it "should call destroy on the found measure" do
      @measure.should_receive(:destroy)
      call_request
    end
  
    it "should redirect to the recipe page" do
      @recipe_category.should_receive(:to_param).at_least(:once).and_return("30")
      @recipe.should_receive(:to_param).at_least(:once).and_return("22")
      call_request
      response.should redirect_to(recipe_category_recipe_url(@recipe_category, @recipe))
    end
  end
end
