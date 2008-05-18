require File.dirname(__FILE__) + '/../spec_helper'

describe Ingredient do
  include DefaultModelHelper
  include IngredientSpecHelper
  
  it_should_behave_like "validates required fields"
  
  it_should_behave_like "find existing records"
  
  it "should belong to an ingredient category" do
    Ingredient.should belong_to(:ingredient_category)
  end
  
  it "should have many measures" do
    Ingredient.should have_many(:measures)
  end
  
  it "should have many recipes through measures" do
    Ingredient.should have_many(:recipes).through(:measures)
  end
  
  it "should belong to an unit" do
    Ingredient.should belong_to(:unit)
  end
  
  it "should belong to a period" do
    Ingredient.should belong_to(:period)
  end
  
  it "should be possible to delete an ingredient if it is not used in any recipes" do
    ingredient = Ingredient.create!(:name => "My ingredient", :ingredient_category => mock_model(IngredientCategory))
    ingredient.stub!(:recipes).and_return([])
    ingredient.destroy.should_not be_false
  end
  
  it "should be impossible to delete an ingredient if it is used in recipes" do
    ingredient = Ingredient.create!(:name => "My ingredient", :ingredient_category => mock_model(IngredientCategory))
    ingredient.stub!(:recipes).and_return([mock_model(Recipe)])
    ingredient.destroy.should be_false
  end
end
