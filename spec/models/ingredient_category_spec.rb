require File.dirname(__FILE__) + '/../spec_helper'

describe IngredientCategory do
  include DefaultModelHelper
  include IngredientCategorySpecHelper
  
  it_should_behave_like "validates required fields"
  
  it "should have many ingredients" do
    IngredientCategory.should have_many(:ingredients)
  end
  
  it_should_behave_like "find existing records"
end

context IngredientCategory, "with ingredients in it" do
  fixtures :ingredient_categories, :ingredients
  
  it "should tell its ingredients" do
    vegetables = IngredientCategory.find(ingredient_categories(:vegetables).id)
    vegetables.should respond_to(:ingredients)
    vegetables.ingredients.should have(1).item
    vegetables.ingredients.first.should eql(ingredients(:carrot))
  end
end
