require File.dirname(__FILE__) + '/../spec_helper'

describe RecipeCategory do
  include DefaultModelHelper
  include RecipeCategorySpecHelper
  
  it_should_behave_like "validates required fields"
  
  it "should have many recipes" do
    RecipeCategory.should have_many(:recipes)
  end
  
  it "should be impossible to destroy a non-empty recipe category" do
    recipe_category = RecipeCategory.create!(:name => "Recipe Category")
    recipe = mock_model(Recipe, :null_object => true)
    recipe_category.recipes << recipe
    recipe_category.save.should be_true
    recipe_category.recipes.should_not be_empty
    
    recipe_category.destroy.should be_false
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
