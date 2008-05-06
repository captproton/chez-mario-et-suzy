require File.dirname(__FILE__) + '/../spec_helper'

describe RecipesController do
  include RecipeSpecHelper
  
  it_should_behave_like "a RESTfully routed resource"
  
  describe 'handling GET to /recipe_categories/1/recipes' do
    before(:each) do
      @recipe = mock_model(Recipe)
      @recipe_category = mock_model(RecipeCategory)
      @recipes = [@recipe]
      @recipes.stub!(:sort_by).and_return(@recipes)
      @recipe_category.stub!(:recipes).and_return(@recipes)
      RecipeCategory.stub!(:find).and_return(@recipe_category)
    end
    
    def do_get
      get :index, :recipe_category_id => "1"
    end
    
    it "should be successful" do
      do_get
      response.should be_success
    end
    
    it "should render index template" do
      do_get
      response.should render_template('index')
    end
    
    it "should find the requested recipe category" do
      RecipeCategory.should_receive(:find).with("1").and_return(@recipe_category)
      do_get
    end
    
    it "should find all recipes in the specified recipe category and sort then by name" do
      @recipe_category.should_receive(:recipes).and_return(@recipes)
      @recipes.should_receive(:sort_by).and_return(@recipes)
      do_get
    end
    
    it "should assign the found recipe category for the view" do
      do_get
      assigns[:recipe_category].should == @recipe_category
    end
    
    it "should assign the found recipes for the view" do
      do_get
      assigns[:recipes].should == @recipes
    end
  end
  
  describe "handling GET to /recipe_categories/1/recipes.xml" do
    before(:each) do
      @recipe = mock_model(Recipe)
      @recipe_category = mock_model(RecipeCategory)
      @recipes = [@recipe]
      @recipes.stub!(:sort_by).and_return(@recipes)
      @recipes.stub!(:to_xml).and_return("XML")
      @recipe_category.stub!(:recipes).and_return(@recipes)
      RecipeCategory.stub!(:find).and_return(@recipe_category)
    end
    
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index, :recipe_category_id => "1"
    end
    
    it "should be successful" do
      do_get
      response.should be_success
    end
    
    it "should find the requested recipe category" do
      RecipeCategory.should_receive(:find).with("1").and_return(@recipe_category)
      do_get
    end
    
    it "should find all recipes in the specified recipe category and sort them by name" do
      @recipe_category.should_receive(:recipes).and_return(@recipes)
      @recipes.should_receive(:sort_by).and_return(@recipes)
      do_get
    end
    
    it "should render the found recipes as xml" do
      @recipes.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end
  
  describe "handling GET to /recipe_categories/30/recipes/1" do
    before(:each) do
      @recipe = mock_model(Recipe)
      @recipe_category = mock_model(RecipeCategory)
      RecipeCategory.stub!(:find).and_return(@recipe_category)
      Recipe.stub!(:find).and_return(@recipe)
    end
    
    def do_get
      get :show, :id => "1", :recipe_category_id => "30"
    end
    
    it "should be succesful" do
      do_get
      response.should be_success
    end
    
    it "should render the show template" do
      do_get
      response.should render_template('show')
    end
    
    it "should find the requested recipe category" do
      RecipeCategory.should_receive(:find).with("30").and_return(@recipe_category)
      do_get
    end
    
    it "should find the requested recipe" do
      Recipe.should_receive(:find).with("1").and_return(@recipe)
      do_get
    end
    
    it "should assign the found recipe for the view" do
      do_get
      assigns[:recipe].should equal(@recipe)
    end
  end
  
  describe "handling GET to /recipe_categories/30/recipes/1" do
    before(:each) do
      @recipe = mock_model(Recipe, :to_xml => "XML")
      @recipe_category = mock_model(RecipeCategory)
      RecipeCategory.stub!(:find).and_return(@recipe_category)
      Recipe.stub!(:find).and_return(@recipe)
    end
    
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1", :recipe_category_id => "30"
    end
    
    it "should be successful" do
      do_get
      response.should be_success
    end
    
    it "should find the requested recipe category" do
      RecipeCategory.should_receive(:find).with("30").and_return(@recipe_category)
      do_get
    end
    
    it "should find the requested recipe" do
      Recipe.should_receive(:find).with("1").and_return(@recipe)
      do_get
    end
    
    it "should render the found recipe as xml" do
      @recipe.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end
  
  describe "handling GET to /recipe_categories/30/recipes/new" do
    before(:each) do
      @recipe = mock_model(Recipe, :null_object => true)
      Recipe.stub!(:new).and_return(@recipe)
      @recipe_category = mock_model(RecipeCategory)
      RecipeCategory.stub!(:find).and_return(@recipe_category)
    end
  
    def do_get
      get :new, :recipe_category_id => "30"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render new template" do
      do_get
      response.should render_template('new')
    end
    
    it "should find the requested recipe category" do
      RecipeCategory.should_receive(:find).with("30").and_return(@recipe_category)
      do_get
    end
  
    it "should create a new record" do
      Recipe.should_receive(:new).and_return(@recipe)
      do_get
    end
  
    it "should not save the new record" do
      @recipe.should_not_receive(:save)
      do_get
    end
    
    it "should set the recipe category for the new recipe" do
      @recipe.should_receive(:recipe_category=).with(@recipe_category)
      do_get
    end
  
    it "should assign the new record for the view" do
      do_get
      assigns[:recipe].should equal(@recipe)
    end
  end

  describe "handling GET to /recipe_categories/30/recipes/1/edit" do
    before(:each) do
      @recipe = mock_model(Recipe)
      Recipe.stub!(:find).and_return(@recipe)
      @recipe_category = mock_model(RecipeCategory)
      RecipeCategory.stub!(:find).and_return(@recipe_category)
    end
  
    def do_get
      get :edit, :id => "1", :recipe_category_id => "30"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render edit template" do
      do_get
      response.should render_template('edit')
    end
    
    it "should find the requested recipe category" do
      RecipeCategory.should_receive(:find).with("30").and_return(@recipe_category)
      do_get
    end
    
    it "should find the requested recipe" do
      Recipe.should_receive(:find).with("1").and_return(@recipe)
      do_get
    end
  
    it "should assign the found record for the view" do
      do_get
      assigns[:recipe].should equal(@recipe)
    end
  end

  describe "handling POST to /recipe_categories/30/recipes" do
    before(:each) do
      @recipe = mock_model(Recipe, :null_object => true, :to_param => "1")
      Recipe.stub!(:new).and_return(@recipe)
      @recipe_category = mock_model(RecipeCategory, :to_param => "30")
      RecipeCategory.stub!(:find).and_return(@recipe_category)
    end
    
    describe "with successful save" do
      def do_post
        @recipe.should_receive(:save).and_return(true)
        post :create, :recipe => {}, :recipe_category_id => "30"
      end
  
      it "should create a new record" do
        Recipe.should_receive(:new).with({}).and_return(@recipe)
        do_post
      end
      
      it "should set the recipe category of the newly created recipe" do
        @recipe.should_receive(:recipe_category=).with(@recipe_category)
        do_post
      end

      it "should redirect to the new recipe" do
        @recipe_category.should_receive(:to_param).at_least(:once).and_return("30")
        @recipe.should_receive(:to_param).at_least(:once).and_return("1")
        do_post
        response.should redirect_to(recipe_category_recipe_url(@recipe_category, @recipe))
      end
    end
    
    describe "with failed save" do
      def do_post
        @recipe.should_receive(:save).and_return(false)
        post :create, :recipe => {}, :recipe_category_id => "30"
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
    end
  end

  describe "handling PUT to /recipe_categories/30/recipes/1" do
    before(:each) do
      @recipe = mock_model(Recipe, :to_param => "1", :null_object => true)
      Recipe.stub!(:find).and_return(@recipe)
      @recipe_category = mock_model(RecipeCategory, :to_param => "30")
      RecipeCategory.stub!(:find).and_return(@recipe_category)
    end
    
    describe "with successful update" do
      def do_put
        put :update, :id => "1", :recipe_category_id => "30", :recipe => {}
      end

      it "should find the requested recipe category" do
        RecipeCategory.should_receive(:find).with("30").and_return(@recipe_category)
        do_put
      end
      
      it "should find the requested recipe" do
        Recipe.should_receive(:find).with("1").and_return(@recipe)
        do_put
      end
      
      it "should update the found recipe" do
        @recipe.should_receive(:update_attributes).with({}).and_return(true)
        do_put
      end

      it "should redirect to the updated recipe" do
        @recipe_category.should_receive(:to_param).at_least(:once).and_return("30")
        @recipe.should_receive(:to_param).at_least(:once).and_return("1")
        do_put
        response.should redirect_to(recipe_category_recipe_url(@recipe_category, @recipe))
      end
    end
    
    describe "with failed update" do
      def do_put
        @recipe.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1", :recipe_category_id => "30", :recipe => {}
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end
    end
  end

  describe "handling DELETE to /recipe_categories/30/recipes/1" do
    before(:each) do
      @recipe = mock_model(Recipe, :destroy => true, :null_object => true)
      Recipe.stub!(:find).and_return(@recipe)
      
      # Mock for redirection
      @new_recipe_for_redirect = mock_model(Recipe, :new_record? => true)
      Recipe.stub!(:new).and_return(@new_recipe_for_redirect)
      
      @recipe_category = mock_model(RecipeCategory, :to_param => "30")
      RecipeCategory.stub!(:find).and_return(@recipe_category)
    end
  
    def do_delete
      delete :destroy, :id => "1", :recipe_category_id => "30"
    end

    it "should find the requested recipe category" do
      RecipeCategory.should_receive(:find).with("30").and_return(@recipe_category)
      do_delete
    end
    
    it "should find the requested recipe" do
      Recipe.should_receive(:find).with("1").and_return(@recipe)
      do_delete
    end
  
    it "should call destroy on the found record" do
      @recipe.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the recipes list" do
      @recipe_category.should_receive(:to_param).at_least(:once).and_return("30")
      do_delete
      response.should redirect_to(recipe_category_recipes_url(@recipe_category))
    end
  end
end
