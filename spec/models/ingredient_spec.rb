require File.dirname(__FILE__) + '/../spec_helper'

describe Ingredient do
  include DefaultModelHelper
  include IngredientSpecHelper
  
  it_should_behave_like "validates required fields"
  
  it "should have Unit.none as unit after validation if the unit field was empty" do
    ingredient = Ingredient.new(valid_attributes.merge({:unit => nil}))
    ingredient.should be_valid
    ingredient.unit.should eql(Unit.none)
  end
  
  it "should have Period.whole_year as period after validation if the period field was empty" do
    ingredient = Ingredient.new(valid_attributes.merge({:period => nil}))
    ingredient.should be_valid
    ingredient.period.should eql(Period.whole_year)
  end
  
  it_should_behave_like "find existing records"
  
  it "should belong to an ingredient category" do
    Ingredient.should belong_to(:ingredient_category)
  end
  
  it "should belong to an unit" do
    Ingredient.should belong_to(:unit)
  end
  
  it "should belong to a period" do
    Ingredient.should belong_to(:period)
  end
end
