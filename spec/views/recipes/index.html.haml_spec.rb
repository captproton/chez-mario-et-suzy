require File.dirname(__FILE__) + '/../../spec_helper'

describe "/recipes/index.html.haml" do
  include RecipesHelper
  
  before(:each) do
    @recipe_category = mock_model(RecipeCategory, :to_param => "1", :name => "Main course")
    
    @recipe_1 = mock_model(Recipe, :id => 1)
    @recipe_1.should_receive(:name).and_return("Sauteed beef")
    @recipe_1.should_receive(:description).and_return("Delicious")
    
    @recipe_2 = mock_model(Recipe, :id => 2)
    @recipe_2.should_receive(:name).and_return("Lemon cocktail")
    @recipe_2.should_receive(:description).and_return("Fresh")

    assigns[:recipe_category] = @recipe_category
    assigns[:recipes] = [@recipe_1, @recipe_2]
  end

  def call_render
    render "/recipes/index.html.haml"
  end

  it "should render list of recipes with their descriptions and link to the full view" do
    call_render
    response.should have_tag("div#recipe_1.recipe") do
      with_tag("h3>a[href=#{recipe_category_recipe_url(@recipe_category, @recipe_1)}]", /Sauteed beef/)
      with_tag("div.textile_text", /Delicious/)
    end
    response.should have_tag("div#recipe_2.recipe") do
      with_tag("h3>a[href=#{recipe_category_recipe_url(@recipe_category, @recipe_2)}]", /Lemon cocktail/)
      with_tag("div.textile_text", /Fresh/)
    end
  end
  
  it_should_behave_like "a page with a flash notice"
end
