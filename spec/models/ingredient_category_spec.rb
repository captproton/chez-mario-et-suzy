require File.dirname(__FILE__) + '/../spec_helper'

describe IngredientCategory do
  include DefaultModelHelper
  include IngredientCategorySpecHelper
  
  it_should_behave_like "validates required fields"
  
  it "should have many ingredients" do
    IngredientCategory.should have_many(:ingredients)
  end
  
  it "should be impossible to destroy a non-empty ingredient category" do
    ingredient_category = IngredientCategory.create!(:name => "Ingredient Category")
    ingredient = mock_model(Ingredient, :null_object => true)
    ingredient_category.ingredients << ingredient
    ingredient_category.save.should be_true
    ingredient_category.ingredients.should_not be_empty
    
    ingredient_category.destroy.should be_false
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
