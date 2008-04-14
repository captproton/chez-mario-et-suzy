require File.dirname(__FILE__) + '/../spec_helper'

describe Measure, "with no number, no recipe and no ingredient" do
  before(:each) do
    @model_instance = Measure.new
  end
  
  it_should_behave_like "invalid model instance"

  it "should have errors on recipe and ingredient" do
    @model_instance.valid?
    @model_instance.should have_at_least(1).error_on(:recipe)
    @model_instance.should have_at_least(1).error_on(:ingredient)
  end
  
  it "should have a number with a default value of 1" do
    @model_instance.valid?
    @model_instance.number.should == 1
  end
end

describe Measure, "with a non-numerical number, a recipe and an ingredient" do
  fixtures :recipes, :ingredients
  
  before(:each) do
    @model_instance = Measure.new(
      :number => "ABC",
      :recipe => recipes(:lemonjuice),
      :ingredient => ingredients(:lemon)
    )
  end
  
  it_should_behave_like "invalid model instance"
  
  it "should have an error on number" do
    @model_instance.valid?
    @model_instance.should have_at_least(1).error_on(:number)
  end
end

describe Measure, "with a number, a recipe and an ingredient" do
  fixtures :recipes, :ingredients
  
  before(:each) do
    @model_instance = Measure.new(
      :number => 10,
      :recipe => recipes(:lemonjuice),
      :ingredient => ingredients(:lemon)
    )
  end
  
  it_should_behave_like "valid model instance"
  
  it "should tell its recipe" do
    @model_instance.should respond_to(:recipe)
    @model_instance.recipe.should eql(recipes(:lemonjuice))
  end
  
  it "should tell its ingredient" do
    @model_instance.should respond_to(:ingredient)
    @model_instance.ingredient.should eql(ingredients(:lemon))
  end
end

describe Measure, "with fixtures loaded" do
  fixtures :measures, :ingredients, :recipes
  
  it "should have a non-empty collection of measures" do
    Measure.find(:all).should_not be_empty
  end
  
  it "should have 3 records" do
    Measure.should have(3).records
  end
  
  it "should find an existing measure" do
    measure = Measure.find(measures(:twokgcarrots).id)
    measure.should eql(measures(:twokgcarrots))
  end
end
