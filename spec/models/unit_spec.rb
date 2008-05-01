require File.dirname(__FILE__) + '/../spec_helper'

describe Unit do
  include DefaultModelHelper
  include UnitSpecHelper
  
  it_should_behave_like "validates required fields"
  
  it "should create Unit.none when it does not exist" do
    Unit.should respond_to(:none)
    none = Unit.none
    none.should be_instance_of(Unit)
    none.name.should == "N/A"
    none.abbreviation.should == "N/A"
  end
  
  it "should find Unit.none when it exists" do
    Unit.delete_all
    none_unit = Unit.create!(:name => 'N/A', :abbreviation => 'N/A')
    
    Unit.should respond_to(:none)
    Unit.none.should eql(none_unit)
  end
  
  it "should return false to #none? when it is not Unit.none" do
    unit = Unit.create!(:name => "Kilogrammes", :abbreviation => "kg")
    unit.should respond_to(:none?)
    unit.none?.should be_false
  end
  
  it "should return true to #none? when it is Unit.none" do
    unit = Unit.none
    unit.should respond_to(:none?)
    unit.none?.should be_true
  end
  
  it_should_behave_like "find existing records"
end
