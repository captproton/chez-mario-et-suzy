require File.dirname(__FILE__) + '/../../spec_helper'

describe "/recipes/show.html.haml" do
  include RecipesHelper
  
  before(:each) do
    @recipe_category = mock_model(RecipeCategory, :id => 1, :to_param => "1")
    
    @recipe = mock_model(Recipe, :id => 1, :to_param => "1")
    @recipe.stub!(:name).and_return("Sauteed beef")
    @recipe.stub!(:description).and_return("Delicious")
    @recipe.stub!(:directions).and_return("Cook it")
    
    @unit_1 = mock_model(Unit, :abbreviation => "kg")
    @ingredient_1 = mock_model(Ingredient, :name => "Beef", :unit => @unit_1)
    @measure_1 = mock_model(Measure, :number => 3, :ingredient => @ingredient_1)
    
    @ingredient_2 = mock_model(Ingredient, :name => "Carrots", :unit => nil)
    @measure_2 = mock_model(Measure, :number => 15, :ingredient => @ingredient_2)
    
    @recipe.stub!(:measures).and_return([ @measure_1, @measure_2 ])

    assigns[:recipe_category] = @recipe_category
    assigns[:recipe] = @recipe
  end

  def call_render
    render "/recipes/show.html.haml", :layout => 'base'
  end

  it "should render the full recipe, measures included" do
    call_render
    response.should have_tag("div#recipe_description", /Delicious/)
    response.should have_tag("div#recipe_ingredients") do
      with_tag("table") do
        with_tag("tr") do
          with_tag("td", /3kg/)
          with_tag("td", /Beef/)
        end
        with_tag("tr") do
          with_tag("td", /15/)
          with_tag("td", /Carrots/)
        end
      end
    end
    response.should have_tag("div#recipe_directions", /Cook it/)
  end
  
  it "should have a link to the recipe measures list" do
    call_render
    response.should have_tag("a[href=/recipe_categories/1/recipes/1/measures]")
  end
  
  it "should have a link back to recipes list" do
    call_render
    response.should have_tag("a[href=/recipe_categories/1/recipes]")
  end
  
  it_should_behave_like "a page in the recipes section"
  
  it_should_behave_like "a page with a flash notice"
end
