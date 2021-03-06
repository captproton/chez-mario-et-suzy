require File.dirname(__FILE__) + '/../spec_helper'

describe "handles units and periods", :shared => true do
  it "should find all units" do
    Unit.should_receive(:find).with(:all).and_return([@unit])
    call_request
  end
  
  it "should find all periods" do
    Period.should_receive(:find).with(:all).and_return([@period])
    call_request
  end
  
  it "should assign all units for the view" do
    call_request
    assigns[:units].should == [@unit]
  end
  
  it "should assign all periods for the view" do
    call_request
    assigns[:periods].should == [@period]
  end
end

describe IngredientsController do
  include IngredientSpecHelper
  
  def init_units_and_periods
    @unit = mock_model(Unit)
    Unit.stub!(:find).and_return([@unit])
    @period = mock_model(Period)
    Period.stub!(:find).and_return([@period])
  end
  
  it_should_behave_like "a RESTfully routed resource"
  
  describe "route for member :recipes" do
    it "should map recipes action to /ingredient_categories/ID/ingredients/ID/recipes" do
      route_for(
        :controller => 'ingredients',
        :action => 'recipes',
        :ingredient_category_id => '24',
        :id => '32'
      ).should == "/ingredient_categories/24/ingredients/32/recipes"
    end
    
    it "should trigger recipes action with ID 1 on GET to /ingredient_categories/24/ingredients/1/recipes" do
      params_from(:get, "/ingredient_categories/24/ingredients/1/recipes").should == {
        :controller => 'ingredients',
        :action => 'recipes',
        :ingredient_category_id => '24',
        :id => '1'
      }
    end
  end
  
  describe 'handling GET to /ingredient_categories/1/ingredients' do
    before(:each) do
      @ingredient_category = mock_model(IngredientCategory, :id => 26)
      IngredientCategory.stub!(:find).and_return(@ingredient_category)
      
      @ingredient = mock_model(Ingredient)
      @ingredients = [@ingredient].paginate
      Ingredient.stub!(:paginate_by_ingredient_category_id).and_return(@ingredients)
    end
    
    def do_get
      get :index, :ingredient_category_id => "26", :page => "2"
    end
    
    it "should be successful" do
      do_get
      response.should be_success
    end
    
    it "should render index template" do
      do_get
      response.should render_template('index')
    end
    
    it "should find the requested ingredient category" do
      IngredientCategory.should_receive(:find).with("26").and_return(@ingredient_category)
      do_get
    end
    
    it "should paginate all ingredients in the specified ingredient category and sort them by name" do
      Ingredient.should_receive(:paginate_by_ingredient_category_id).with(26, :page => "2", :order => "name", :per_page => 5).and_return(@ingredients)
      do_get
    end
    
    it "should assign the found ingredient category for the view" do
      do_get
      assigns[:ingredient_category].should == @ingredient_category
    end
    
    it "should assign the found ingredients for the view" do
      do_get
      assigns[:ingredients].should == @ingredients
    end
  end
  
  describe "handling GET to /ingredient_categories/1/ingredients.xml" do
    before(:each) do
      @ingredient = mock_model(Ingredient)
      @ingredient_category = mock_model(IngredientCategory)
      @ingredients = [@ingredient]
      @ingredients.stub!(:sort_by).and_return(@ingredients)
      @ingredients.stub!(:to_xml).and_return("XML")
      @ingredient_category.stub!(:ingredients).and_return(@ingredients)
      IngredientCategory.stub!(:find).and_return(@ingredient_category)
    end
    
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index, :ingredient_category_id => "1"
    end
    
    it "should be successful" do
      do_get
      response.should be_success
    end
    
    it "should find the requested ingredient category" do
      IngredientCategory.should_receive(:find).with("1").and_return(@ingredient_category)
      do_get
    end
    
    it "should find all ingredients in the specified ingredient category and sort them by name" do
      @ingredient_category.should_receive(:ingredients).and_return(@ingredients)
      @ingredients.should_receive(:sort_by).and_return(@ingredients)
      do_get
    end
    
    it "should render the found ingredients as xml" do
      @ingredients.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end
  
  describe "handling GET to /ingredient_categories/30/ingredients/1.xml" do
    before(:each) do
      @ingredient = mock_model(Ingredient, :to_xml => "XML")
      @ingredient_category = mock_model(IngredientCategory)
      IngredientCategory.stub!(:find).and_return(@ingredient_category)
      Ingredient.stub!(:find).and_return(@ingredient)
    end
    
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1", :ingredient_category_id => "30"
    end
    
    it "should be successful" do
      do_get
      response.should be_success
    end
    
    it "should find the requested ingredient category" do
      IngredientCategory.should_receive(:find).with("30").and_return(@ingredient_category)
      do_get
    end
    
    it "should find the requested ingredient" do
      Ingredient.should_receive(:find).with("1").and_return(@ingredient)
      do_get
    end
    
    it "should render the found ingredient as xml" do
      @ingredient.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end
  
  describe "handling GET to /ingredient_categories/30/ingredients/1/recipes" do
    before(:each) do
      @ingredient_category = mock_model(IngredientCategory)
      IngredientCategory.stub!(:find).and_return(@ingredient_category)
      
      @ingredient = mock_model(Ingredient)
      Ingredient.stub!(:find).and_return(@ingredient)
      
      @recipe = mock_model(Recipe)
      @recipes = [@recipes]
      @ingredient.stub!(:recipes).and_return(@recipes)
      @recipes.stub!(:paginate).and_return(@recipes.paginate)
    end
    
    def do_get
      get :recipes, :ingredient_category_id => "30", :id => "1", :page => "2"
    end
    
    it "should be successful" do
      do_get
      response.should be_success
    end
    
    it "should render recipes template" do
      do_get
      response.should render_template('recipes')
    end
    
    it "should find the requested ingredient category" do
      IngredientCategory.should_receive(:find).with("30").and_return(@ingredient_category)
      do_get
    end
    
    it "should find the requested ingredient" do
      Ingredient.should_receive(:find).with("1").and_return(@ingredient)
      do_get
    end
    
    it "should paginate recipes in which the ingredient is used and sort them by name" do
      @ingredient.should_receive(:recipes).and_return(@recipes)
      @recipes.should_receive(:paginate).with(:page => "2", :order => "name", :per_page => 5).and_return(@recipes.paginate)
      do_get
    end
    
    it "should assign the found ingredient for the view" do
      do_get
      assigns[:ingredient].should == @ingredient
    end
    
    it "should assign the found recipes for the view" do
      do_get
      assigns[:recipes].should == @recipes.paginate
    end
  end
  
  describe "handling GET to /ingredient_categories/30/ingredients/1/recipes.xml" do
    before(:each) do
      @recipe = mock_model(Recipe)
      @recipes = [@recipe]
      @recipes.stub!(:to_xml).and_return("XML")
      @ingredient = mock_model(Ingredient)
      @ingredient.stub!(:recipes).and_return(@recipes)
      @ingredient_category = mock_model(IngredientCategory)
      IngredientCategory.stub!(:find).and_return(@ingredient_category)
      Ingredient.stub!(:find).and_return(@ingredient)
    end
    
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :recipes, :ingredient_category_id => "30", :id => "1"
    end
    
    it "should be successful" do
      do_get
      response.should be_success
    end
    
    it "should find the requested ingredient category" do
      IngredientCategory.should_receive(:find).with("30").and_return(@ingredient_category)
      do_get
    end
    
    it "should find the requested ingredient" do
      Ingredient.should_receive(:find).with("1").and_return(@ingredient)
      do_get
    end
    
    it "should find recipes in which the ingredient is used" do
      @ingredient.should_receive(:recipes).and_return(@recipes)
      do_get
    end
    
    it "should render the found recipes as xml" do
      @recipes.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end
  
  describe "handling GET to /ingredient_categories/30/ingredients/new" do
    before(:each) do
      @ingredient = mock_model(Ingredient, :null_object => true)
      Ingredient.stub!(:new).and_return(@ingredient)
      
      @ingredient_category = mock_model(IngredientCategory)
      @ingredient_categories = []
      IngredientCategory.stub!(:find).and_return(@ingredient_category, @ingredient_categories)
      
      init_units_and_periods
    end
  
    def do_get
      get :new, :ingredient_category_id => "30"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render new template" do
      do_get
      response.should render_template('new')
    end
    
    it "should find the requested ingredient category" do
      IngredientCategory.should_receive(:find).with("30").and_return(@ingredient_category)
      do_get
    end
    
    it "should find all ingredient categories" do
      IngredientCategory.should_receive(:find).with(:all).and_return(@ingredient_categories)
      do_get
    end
  
    it "should create a new record" do
      Ingredient.should_receive(:new).and_return(@ingredient)
      do_get
    end
  
    it "should not save the new record" do
      @ingredient.should_not_receive(:save)
      do_get
    end
    
    it "should set the ingredient category for the new ingredient" do
      @ingredient.should_receive(:ingredient_category=).with(@ingredient_category)
      do_get
    end
  
    it "should assign the new record for the view" do
      do_get
      assigns[:ingredient].should equal(@ingredient)
    end
    
    it "should assign ingredient categories for the view" do
      do_get
      assigns[:ingredient_categories].should equal(@ingredient_categories)
    end
    
    def call_request; do_get; end
    it_should_behave_like "handles units and periods"
  end

  describe "handling GET to /ingredient_categories/30/ingredients/1/edit" do
    before(:each) do
      @ingredient = mock_model(Ingredient)
      Ingredient.stub!(:find).and_return(@ingredient)
      
      @ingredient_category = mock_model(IngredientCategory)
      @ingredient_categories = []
      IngredientCategory.stub!(:find).and_return(@ingredient_category, @ingredient_categories)
      
      init_units_and_periods
    end
  
    def do_get
      get :edit, :id => "1", :ingredient_category_id => "30"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render edit template" do
      do_get
      response.should render_template('edit')
    end
    
    it "should find the requested ingredient category" do
      IngredientCategory.should_receive(:find).with("30").and_return(@ingredient_category)
      do_get
    end
    
    it "should find the requested ingredient" do
      Ingredient.should_receive(:find).with("1").and_return(@ingredient)
      do_get
    end
    
    it "should find all ingredient categories" do
      IngredientCategory.should_receive(:find).with(:all).and_return(@ingredient_categories)
      do_get
    end
  
    it "should assign the found record for the view" do
      do_get
      assigns[:ingredient].should equal(@ingredient)
    end
    
    it "should assign ingredient categories for the view" do
      do_get
      assigns[:ingredient_categories].should equal(@ingredient_categories)
    end
    
    def call_request; do_get; end
    it_should_behave_like "handles units and periods"
  end

  describe "handling POST to /ingredient_categories/30/ingredients" do
    before(:each) do
      @ingredient = mock_model(Ingredient, :null_object => true, :to_param => "1")
      # Mock for redirection
      @new_ingredient_for_redirect = mock_model(Ingredient, :new_record? => true)
      Ingredient.stub!(:new).and_return(@ingredient, @new_ingredient_for_redirect)
      
      @ingredient_category = mock_model(IngredientCategory, :to_param => "30")
      IngredientCategory.stub!(:find).and_return(@ingredient_category)
      init_units_and_periods
    end
    
    describe "with successful save" do
      def do_post
        @ingredient.should_receive(:save).and_return(true)
        post :create, :ingredient => {}, :ingredient_category_id => "30"
      end
  
      it "should create a new record" do
        Ingredient.should_receive(:new).with({}).and_return(@ingredient)
        do_post
      end
      
      it "should set the ingredient category of the newly created ingredient" do
        @ingredient.should_receive(:ingredient_category=).with(@ingredient_category)
        do_post
      end

      it "should redirect to the ingredients list" do
        @ingredient_category.should_receive(:to_param).at_least(:once).and_return("30")
        do_post
        response.should redirect_to(ingredient_category_ingredients_url(@ingredient_category))
      end
    end
    
    describe "with failed save" do
      def do_post
        @ingredient.should_receive(:save).and_return(false)
        post :create, :ingredient => {}, :ingredient_category_id => "30"
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
      def call_request; do_post; end
      it_should_behave_like "handles units and periods"
    end
  end

  describe "handling PUT to /ingredient_categories/30/ingredients/1" do
    before(:each) do
      @ingredient = mock_model(Ingredient, :to_param => "1", :null_object => true)
      Ingredient.stub!(:find).and_return(@ingredient)
      
      # Mock for redirection
      @new_ingredient_for_redirect = mock_model(Ingredient, :new_record? => true)
      Ingredient.stub!(:new).and_return(@new_ingredient_for_redirect)
      
      @ingredient_category = mock_model(IngredientCategory, :to_param => "30")
      IngredientCategory.stub!(:find).and_return(@ingredient_category)
      init_units_and_periods
    end
    
    describe "with successful update" do
      def do_put
        put :update, :id => "1", :ingredient_category_id => "30", :ingredient => {}
      end

      it "should find the requested ingredient category" do
        IngredientCategory.should_receive(:find).with("30").and_return(@ingredient_category)
        do_put
      end
      
      it "should find the requested ingredient" do
        Ingredient.should_receive(:find).with("1").and_return(@ingredient)
        do_put
      end
      
      it "should update the found ingredient" do
        @ingredient.should_receive(:update_attributes).with({}).and_return(true)
        do_put
      end

      it "should redirect to the ingredients list" do
        @ingredient_category.should_receive(:to_param).at_least(:once).and_return("30")
        do_put
        response.should redirect_to(ingredient_category_ingredients_url(@ingredient_category))
      end
    end
    
    describe "with failed update" do
      def do_put
        @ingredient.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1", :ingredient_category_id => "30", :ingredient => {}
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end
      
      def call_request; do_put; end
      it_should_behave_like "handles units and periods"
    end
  end

  describe "handling DELETE to /ingredient_categories/30/ingredients/1" do
    before(:each) do
      @ingredient = mock_model(Ingredient, :destroy => true, :null_object => true)
      Ingredient.stub!(:find).and_return(@ingredient)
      
      # Mock for redirection
      @new_ingredient_for_redirect = mock_model(Ingredient, :new_record? => true)
      Ingredient.stub!(:new).and_return(@new_ingredient_for_redirect)
      
      @ingredient_category = mock_model(IngredientCategory, :to_param => "30")
      IngredientCategory.stub!(:find).and_return(@ingredient_category)
    end
  
    def do_delete
      delete :destroy, :id => "1", :ingredient_category_id => "30"
    end

    it "should find the requested ingredient category" do
      IngredientCategory.should_receive(:find).with("30").and_return(@ingredient_category)
      do_delete
    end
    
    it "should find the requested ingredient" do
      Ingredient.should_receive(:find).with("1").and_return(@ingredient)
      do_delete
    end
  
    it "should call destroy on the found record" do
      @ingredient.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the ingredients list" do
      @ingredient_category.should_receive(:to_param).at_least(:once).and_return("30")
      do_delete
      response.should redirect_to(ingredient_category_ingredients_url(@ingredient_category))
    end
  end
end
