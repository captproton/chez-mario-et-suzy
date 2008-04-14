require File.dirname(__FILE__) + '/../spec_helper'

describe IngredientCategory, "with no name" do
  before(:each) do
    @model_instance = IngredientCategory.new
  end

  it_should_behave_like "invalid model instance"
  
  it "should have error on name after validation" do
    @model_instance.valid?
    @model_instance.should have_at_least(1).error_on(:name)
  end
end

describe IngredientCategory, "with a name" do
  before(:each) do
    @model_instance = IngredientCategory.new(:name => "Vegetables")
  end
  
  it_should_behave_like "valid model instance"
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

describe IngredientCategory, "with fixtures loaded" do
  fixtures :ingredient_categories
  
  it "should have a non-empty collection of ingredient categories" do
    IngredientCategory.find(:all).should_not be_empty
  end
  
  it "should have 5 ingredient categories" do
    IngredientCategory.should have(5).records
  end
  
  it "should find an existing ingredient category" do
    ingredient_category = IngredientCategory.find(ingredient_categories(:meat).id)
    ingredient_category.should eql(ingredient_categories(:meat))
  end
end
