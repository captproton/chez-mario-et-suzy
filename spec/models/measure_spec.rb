require File.dirname(__FILE__) + '/../spec_helper'

describe Measure do
  include DefaultModelHelper
  include MeasureSpecHelper
  
  it_should_behave_like "validates required fields"
  
  it "should have 1 as number after validation if the number field was empty" do
    measure = Measure.new(valid_attributes.merge({:number => nil}))
    measure.should be_valid
    measure.number.should eql(1)
  end
  
  it "should belong to a recipe" do
    Measure.should belong_to(:recipe)
  end
  
  it "should belong to an ingredient" do
    Measure.should belong_to(:ingredient)
  end
  
  it_should_behave_like "find existing records"
end
