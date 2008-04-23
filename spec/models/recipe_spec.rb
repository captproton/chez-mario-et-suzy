require File.dirname(__FILE__) + '/../spec_helper'

describe Recipe do
  include DefaultModelHelper
  include RecipeSpecHelper
  
  it_should_behave_like "validates required fields"
  
  it "should belong to a recipe category" do
    Recipe.should belong_to(:recipe_category)
  end
  
  it "should have many measures" do
    Recipe.should have_many(:measures)
  end
  
  it "should have many ingredients through measures" do
    Recipe.should have_many(:ingredients).through(:measures)
  end
  
  it_should_behave_like "find existing records"
end
