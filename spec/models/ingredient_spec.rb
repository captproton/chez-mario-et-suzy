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
end
