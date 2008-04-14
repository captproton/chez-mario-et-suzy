require File.dirname(__FILE__) + '/../spec_helper'

shared_examples_for "ingredient with no unit nor period" do
  it "should have the default unit <none> after validation" do
    @model_instance.valid?
    @model_instance.unit.name.should eql(units(:none).name)
    @model_instance.unit.abbreviation.should eql(units(:none).abbreviation)
  end
  
  it "should have the default period <wholeyear> after validation" do
    @model_instance.valid?
    @model_instance.period.start_month.should eql(periods(:wholeyear).start_month)
    @model_instance.period.end_month.should eql(periods(:wholeyear).end_month)
  end
end

describe Ingredient, "with no name, no ingredient category, no unit and no period" do
  fixtures :units, :periods
  
  before(:each) do
    @model_instance = Ingredient.new
  end

  it_should_behave_like "invalid model instance"

  it "should have errors on ingredient category after validation" do
    @model_instance.valid?
    @model_instance.should have_at_least(1).error_on(:name)
    @model_instance.should have_at_least(1).error_on(:ingredient_category)
  end
  
  it_should_behave_like "ingredient with no unit nor period"
end

describe Ingredient, "with a name and ingredient category but no unit nor period" do
  fixtures :ingredient_categories, :units, :periods
  
  before(:each) do
    @model_instance = Ingredient.new(
      :name => "Tomatoes",
      :ingredient_category => ingredient_categories(:vegetables)
    )
  end
  
  it_should_behave_like "valid model instance"
  
  it_should_behave_like "ingredient with no unit nor period"
end

describe Ingredient, "with a name, an ingredient category, a unit and a period" do
  fixtures :ingredient_categories, :units, :periods
  
  before(:each) do
    @model_instance = Ingredient.new(
      :name => "Tomatoes",
      :ingredient_category => ingredient_categories(:vegetables),
      :unit => units(:kg),
      :period => periods(:junsep)
    )
  end
  
  it_should_behave_like "valid model instance"
  
  it "should tell its ingredient category" do
    @model_instance.should respond_to(:ingredient_category)
    @model_instance.ingredient_category.should eql(ingredient_categories(:vegetables))
  end
  
  it "should tell its unit" do
    @model_instance.should respond_to(:unit)
    @model_instance.unit.should eql(units(:kg))
  end
  
  it "should tell its period" do
    @model_instance.should respond_to(:period)
    @model_instance.period.should eql(periods(:junsep))
  end
end

describe Ingredient, "with fixtures loaded" do
  fixtures :ingredients, :ingredient_categories, :units, :periods
  
  it "should have a non-empty collection of ingredients" do
    Ingredient.find(:all).should_not be_empty
  end
  
  it "should have 3 ingredients" do
    Ingredient.should have(3).records
  end
  
  it "should find an existing ingredient" do
    ingredient = Ingredient.find(ingredients(:beef).id)
    ingredient.should eql(ingredients(:beef))
  end
end
