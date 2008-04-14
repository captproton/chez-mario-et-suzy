require File.dirname(__FILE__) + '/../spec_helper'

describe Period, "with no start month nor end month" do
  before(:each) do
    @model_instance = Period.new
  end

  it_should_behave_like "invalid model instance"

  it "should have errors on start_month and end_month" do
    @model_instance.valid?
    @model_instance.should have_at_least(1).error_on(:start_month)
    @model_instance.should have_at_least(1).error_on(:end_month)
  end
end

describe Period, "with no end_month" do
  before(:each) do
    @model_instance = Period.new(:start_month => 1)
  end
  
  it_should_behave_like "invalid model instance"
  
  it "should have error on end_month" do
    @model_instance.valid?
    @model_instance.should have_at_least(1).error_on(:end_month)
  end
end

describe Period, "with no start_month" do
  before(:each) do
    @model_instance = Period.new(:end_month => 12)
  end
  
  it_should_behave_like "invalid model instance"
  
  it "should have error on start_month" do
    @model_instance.valid?
    @model_instance.should have_at_least(1).error_on(:start_month)
  end
end

describe Period, "with non numerical values for start_month and end_month" do
  before(:each) do
    @model_instance = Period.new(:start_month => "ABC", :end_month => "XYZ")
  end
  
  it_should_behave_like "invalid model instance"
  
  it "should have errors on start_month and end_month" do
    @model_instance.valid?
    @model_instance.should have_at_least(1).error_on(:start_month)
    @model_instance.should have_at_least(1).error_on(:end_month)
  end
end

describe Period, "with start_month and end_month not in 1..12" do
  before(:each) do
    @model_instance = Period.new(:start_month => -34, :end_month => 102)
  end
  
  it_should_behave_like "invalid model instance"
  
  it "should have errors on start_month and end_month" do
    @model_instance.valid?
    @model_instance.should have_at_least(1).error_on(:start_month)
    @model_instance.should have_at_least(1).error_on(:end_month)
  end
end

describe Period, "with start_month and end_month" do
  before(:each) do
    @model_instance = Period.new(:start_month => 1, :end_month => 12)
  end
  
  it_should_behave_like "valid model instance"
  
  it "should respond to #start_month_symbol" do
    @model_instance.should respond_to(:start_month_symbol)
  end
  
  it "should answer :january when sent #start_month_symbol" do
    @model_instance.start_month_symbol.should eql(:january)
  end
  
  it "should respond to #end_month_symbol" do
    @model_instance.should respond_to(:end_month_symbol)
  end
  
  it "should answer :december when sent #end_month_symbol" do
    @model_instance.end_month_symbol.should eql(:december)
  end
  
  it "should create whole_year when it doesn't exist" do
    Period.should respond_to(:whole_year)
    whole_year = Period.whole_year
    whole_year.should be_instance_of(Period)
    whole_year.start_month.should == 1
    whole_year.end_month.should == 12
  end
end

describe Period, "with fixtures loaded" do
  fixtures :periods
  
  it "should have a non-empty collection of periods" do
    Period.find(:all).should_not be_empty
  end
  
  it "should have 6 records" do
    Period.should have(6).records
  end
  
  it "should find an existing period" do
    period = Period.find(periods(:wholeyear).id)
    period.should eql(periods(:wholeyear))
  end
  
  it "should find whole_year when it exists" do
    Period.should respond_to(:whole_year)
    Period.whole_year.should eql(periods(:wholeyear))
  end
end
