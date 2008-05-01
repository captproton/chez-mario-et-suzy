require File.dirname(__FILE__) + '/../../spec_helper'

describe "/recipe_categories/index.html.haml" do
  include RecipeCategoriesHelper
  
  before(:each) do
    recipe_category_1 = mock_model(RecipeCategory, :id => 1)
    recipe_category_1.should_receive(:name).and_return("Main course")
    recipes_1 = mock("recipes 1")
    recipes_1.should_receive(:size).and_return(21)
    recipe_category_1.should_receive(:recipes).and_return(recipes_1)
    
    recipe_category_2 = mock_model(RecipeCategory, :id => 2)
    recipe_category_2.should_receive(:name).and_return("Desserts")
    recipes_2 = mock("recipes 2")
    recipes_2.should_receive(:size).and_return(33)
    recipe_category_2.should_receive(:recipes).and_return(recipes_2)

    assigns[:recipe_categories] = [recipe_category_1, recipe_category_2]
  end

  def call_render
    render "/recipe_categories/index.html.haml"
  end

  it "should render list of recipe categories with their number of recipes" do
    call_render
    response.should have_tag("div#recipe_category_1.recipe_category") do
      with_tag("h3", /Main course/)
      with_tag("span.count", /21/)
    end
    response.should have_tag("div#recipe_category_2.recipe_category") do
      with_tag("h3", /Desserts/)
      with_tag("span.count", /33/)
    end
  end
  
  it_should_behave_like "a page with a flash notice"
end
