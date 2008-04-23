require File.dirname(__FILE__) + '/../spec_helper'

describe RecipeCategory do
  include DefaultModelHelper
  include RecipeCategorySpecHelper
  
  it_should_behave_like "validates required fields"
  
  it "should have many recipes" do
    RecipeCategory.should have_many(:recipes)
  end
  
  it_should_behave_like "find existing records"
end

context RecipeCategory, "with recipes in it" do
  fixtures :recipe_categories, :recipes
  
  it "should tell its recipes" do
    coktail = RecipeCategory.find(recipe_categories(:coktail).id)
    coktail.should respond_to(:recipes)
    coktail.recipes.should have(1).item
    coktail.recipes.first.should eql(recipes(:lemonjuice))
  end
end
