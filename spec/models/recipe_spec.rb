require File.dirname(__FILE__) + '/../spec_helper'

describe Recipe, "with no name, no description, no directions, no recipe category" do
  before(:each) do
    @model_instance = Recipe.new
  end

  it_should_behave_like "invalid model instance"
  
  it "should have errors on name, description, directions and recipe category" do
    @model_instance.valid?
    @model_instance.should have_at_least(1).error_on(:name)
    @model_instance.should have_at_least(1).error_on(:description)
    @model_instance.should have_at_least(1).error_on(:directions)
    @model_instance.should have_at_least(1).error_on(:recipe_category)
  end
end

describe Recipe, "with a name, a describe, directions and a recipe category" do
  fixtures :recipe_categories
  
  before(:each) do
    @model_instance = Recipe.new(
      :name => "test name",
      :description => "test description",
      :directions => "test directions",
      :recipe_category => recipe_categories(:dessert)
    )
  end
  
  it_should_behave_like "valid model instance"
  
  it "should tell its recipe category" do
    @model_instance.should respond_to(:recipe_category)
    @model_instance.recipe_category.should eql(recipe_categories(:dessert))
  end
end

describe Recipe, "with measures" do
  fixtures :recipes, :recipe_categories, :ingredients, :units, :periods, :ingredient_categories
  
  before(:each) do
    @recipe = Recipe.new(
      :name => "test name",
      :description => "test description",
      :directions => "test directions",
      :recipe_category => recipe_categories(:dessert)
    )
    @recipe.save
  end
  
  it "should be able to store measures" do
    @recipe.should respond_to(:measures)
    measure = Measure.new(:number => 2, :ingredient => ingredients(:lemon))
    @recipe.measures << measure
    @recipe.reload
    @recipe.measures.should have(1).item
    measure.recipe.should eql(@recipe)
  end
  
  it "should tell its ingredients through measures" do
    @recipe.should respond_to(:measures)
    m1 = Measure.new(:number => 2, :ingredient => ingredients(:lemon))
    m2 = Measure.new(:number => 6, :ingredient => ingredients(:carrot))
    @recipe.measures << m1
    @recipe.measures << m2
    @recipe.reload
    @recipe.should respond_to(:ingredients)
    @recipe.ingredients.should have(2).items
    @recipe.ingredients.should include(ingredients(:lemon))
    @recipe.ingredients.should include(ingredients(:carrot))
  end
end

describe Recipe, "with fixtures loaded" do
  fixtures :recipes, :recipe_categories, :ingredients, :units, :periods, :ingredient_categories
  
  it "should have a non-empty collection of recipes" do
    Recipe.find(:all).should_not be_empty
  end
  
  it "should have 2 records" do
    Recipe.should have(2).records
  end
  
  it "should find an existing recipe" do
    recipe = Recipe.find(recipes(:lemonjuice).id)
    recipe.should eql(recipes(:lemonjuice))
  end
end
