require File.dirname(__FILE__) + '/../../spec_helper'

describe "/ingredients/recipes.html.haml" do
  include IngredientsHelper
  include ViewSpecHelper
  
  before(:each) do
    @ingredient_category = mock_model(IngredientCategory, :to_param => "1")
    @ingredient = mock_model(Ingredient, :name => "Beef", :to_param => "1")
    
    @recipe_category = mock_model(RecipeCategory, :id => 1, :to_param => "1")
    
    @recipe_1 = mock_model(Recipe, :id => 1, :to_param => "1")
    @recipe_1.should_receive(:name).and_return("Sauteed beef")
    @recipe_1.should_receive(:description).and_return("Delicious")
    @recipe_1.should_receive(:recipe_category).at_least(:once).and_return(@recipe_category)
    
    @recipe_2 = mock_model(Recipe, :id => 2, :to_param => "2")
    @recipe_2.should_receive(:name).and_return("Lemon cocktail")
    @recipe_2.should_receive(:description).and_return("Fresh")
    @recipe_2.should_receive(:recipe_category).at_least(:once).and_return(@recipe_category)
    
    # This recipe should be on page 2
    @recipe_3 = mock_model(Recipe)

    assigns[:ingredient] = @ingredient
    assigns[:ingredient_category] = @ingredient_category
    assigns[:recipes] = [@recipe_1, @recipe_2, @recipe_3].paginate(:per_page => 2)
  end

  def call_render
    render "/ingredients/recipes.html.haml", :layout => 'base'
  end

  it "should render list of recipes with their descriptions and link to the full view" do
    call_render
    response.should have_tag("div#recipe_1.recipe") do
      with_tag("h3>a[href=/recipe_categories/1/recipes/1]", /Sauteed beef/)
      with_tag("div.textile_text", /Delicious/)
    end
    response.should have_tag("div#recipe_2.recipe") do
      with_tag("h3>a[href=/recipe_categories/1/recipes/2]", /Lemon cocktail/)
      with_tag("div.textile_text", /Fresh/)
    end
  end
  
  it "should not render the third recipe which is on next page" do
    call_render
    response.should have_tag("div.recipe", 2)
  end
  
  it "should render an edit link for each recipe" do
    call_render
    response.should have_tag("div#recipe_1") do
      with_tag("a[href=/recipe_categories/1/recipes/1/edit]")
    end
    response.should have_tag("div#recipe_2") do
      with_tag("a[href=/recipe_categories/1/recipes/2/edit]")
    end
  end
  
  it "should render a delete link for each recipe" do
    call_render
    response.should have_tag("div#recipe_1") do
      with_tag("a[href=/recipe_categories/1/recipes/1][onclick=?]", delete_link_pattern)
    end
    response.should have_tag("div#recipe_2") do
      with_tag("a[href=/recipe_categories/1/recipes/2][onclick=?]", delete_link_pattern)
    end
  end
  
  it "should render the pagination block" do
    call_render
    response.should have_tag("div.pagination")
  end
  
  it_should_behave_like "a page in the ingredients section"
end
