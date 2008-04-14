require File.dirname(__FILE__) + '/../spec_helper'

describe RecipeCategory, "with no name" do
  before(:each) do
    @model_instance = RecipeCategory.new
  end

  it_should_behave_like "invalid model instance"
  
  it "should have error on name after validation" do
    @model_instance.valid?
    @model_instance.should have_at_least(1).error_on(:name)
  end
end

describe RecipeCategory, "with a name" do
  before(:each) do
    @model_instance = RecipeCategory.new(:name => "Vegetables")
  end
  
  it_should_behave_like "valid model instance"
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

describe RecipeCategory, "with fixtures loaded" do
  fixtures :recipe_categories
  
  it "should have a non-empty collection of recipe categories" do
    RecipeCategory.find(:all).should_not be_empty
  end
  
  it "should have 4 recipe categories" do
    RecipeCategory.should have(4).records
  end
  
  it "should find an existing ingredient category" do
    recipe_category = RecipeCategory.find(recipe_categories(:maincourse).id)
    recipe_category.should eql(recipe_categories(:maincourse))
  end
end
