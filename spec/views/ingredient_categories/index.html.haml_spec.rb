require File.dirname(__FILE__) + '/../../spec_helper'

describe "/ingredient_categories/index.html.haml" do
  include IngredientCategoriesHelper
  
  before(:each) do
    ingredient_category_1 = mock_model(IngredientCategory, :id => 1)
    ingredient_category_1.should_receive(:name).and_return("Vegetables")
    ingredients_1 = mock("ingredients 1")
    ingredients_1.should_receive(:size).and_return(3)
    ingredient_category_1.should_receive(:ingredients).and_return(ingredients_1)
    
    ingredient_category_2 = mock_model(IngredientCategory, :id => 2)
    ingredient_category_2.should_receive(:name).and_return("Meat")
    ingredients_2 = mock("ingredients 2")
    ingredients_2.should_receive(:size).and_return(7)
    ingredient_category_2.should_receive(:ingredients).and_return(ingredients_2)

    assigns[:ingredient_categories] = [ingredient_category_1, ingredient_category_2]
  end
  
  def call_render
    render "/ingredient_categories/index.html.haml"
  end

  it "should render list of ingredient categories with their number of ingredients" do
    call_render
    response.should have_tag("div#ingredient_category_1.ingredient_category") do
      with_tag("h3", /Vegetables/)
      with_tag("span.count", /3/)
    end
    response.should have_tag("div#ingredient_category_2.ingredient_category") do
      with_tag("h3", /Meat/)
      with_tag("span.count", /7/)
    end
  end
  
  it_should_behave_like "a page with a flash notice"
end
