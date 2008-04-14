require File.dirname(__FILE__) + '/../spec_helper'

describe Unit, "with no name nor abbreviation" do
  before(:each) do
    @model_instance = Unit.new
  end
  
  it_should_behave_like "invalid model instance"

  it "should have errors on name and abbreviation after validation" do
    @model_instance.valid?
    @model_instance.should have(1).error_on(:name)
    @model_instance.should have(1).error_on(:abbreviation)
  end
end

describe Unit, "with no abbreviation" do
  before(:each) do
    @model_instance = Unit.new(:name => "Kilogrammes")
  end
  
  it_should_behave_like "invalid model instance"
  
  it "should have error on abbreviation" do
    @model_instance.valid?
    @model_instance.should have(1).error_on(:abbreviation)
  end
end

describe Unit, "with no name" do
  before(:each) do
    @model_instance = Unit.new(:abbreviation => "kg")
  end
  
  it_should_behave_like "invalid model instance"
  
  it "should have error on name" do
    @model_instance.valid?
    @model_instance.should have(1).error_on(:name)
  end
end

describe Unit, "with name and abbreviation" do
  before(:each) do
    @model_instance = Unit.new(:name => "Kilogrames", :abbreviation => "kg")
  end
  
  it_should_behave_like "valid model instance"
  
  it "should create none when it does not exist" do
    Unit.should respond_to(:none)
    none = Unit.none
    none.should be_instance_of(Unit)
    none.name.should == "N/A"
    none.abbreviation.should == "N/A"
  end
end

describe Unit, "with fixtures loaded" do
  fixtures :units
  
  it "should have a non-empty collection of units" do
    Unit.find(:all).should_not be_empty
  end
  
  it "should have 5 units" do
    Unit.should have(5).records
  end
  
  it "should find an existing unit" do
    unit = Unit.find(units(:kg).id)
    unit.should eql(units(:kg))
  end
  
  it "should find none when it exists" do
    Unit.should respond_to(:none)
    Unit.none.should eql(units(:none))
  end
end