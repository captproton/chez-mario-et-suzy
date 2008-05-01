require File.dirname(__FILE__) + '/../spec_helper'

describe Period do
  include DefaultModelHelper
  include PeriodSpecHelper
  
  before(:all) do
    @month_symbols = [
      :january, :february, :march, :april, :may, :june,
      :july, :august, :september, :october, :november, :december
    ]
  end
  
  it_should_behave_like "validates required fields"
  
  it "should not be valid with non numerical values for start_month and end_month" do
    period = Period.new(:start_month => "ABC", :end_month => "XYZ")
    
    period.should have_at_least(1).error_on(:start_month)
    period.should have_at_least(1).error_on(:end_month)
  end
  
  it "should not be valid with values for start_month and end_month not between 1 and 12" do
    period = Period.new(:start_month => -34, :end_month => 102)
    
    period.should have_at_least(1).error_on(:start_month)
    period.should have_at_least(1).error_on(:end_month)
  end
  
  it "should create Period.whole_year when it doesn't exist" do
    Period.should respond_to(:whole_year)
    whole_year = Period.whole_year
    whole_year.should be_instance_of(Period)
    whole_year.start_month.should == 1
    whole_year.end_month.should == 12
  end
  
  it "should find Period.whole_year when it exists" do
    Period.delete_all
    whole_year_period = Period.create(:start_month => 1, :end_month => 12)
    
    Period.should respond_to(:whole_year)
    Period.whole_year.should eql(whole_year_period)
  end
  
  it "should respond with the correct month symbol to #start_month_symbol" do
    period = Period.create!(:start_month => 1, :end_month => 1)
    period.should respond_to(:start_month_symbol)
    @month_symbols.each_with_index do |month_symbol, index|
      period.start_month = index + 1
      period.start_month_symbol.should == month_symbol
    end
  end
  
  it "should respond with the correct month symbol to #end_month_symbol" do
    period = Period.create!(:start_month => 1, :end_month => 1)
    period.should respond_to(:end_month_symbol)
    @month_symbols.each_with_index do |month_symbol, index|
      period.end_month = index + 1
      period.end_month_symbol.should == month_symbol
    end
  end
  
  it "should return false to #whole_year? when it is not Period.whole_year" do
    period = Period.create!(:start_month => 1, :end_month => 3)
    period.should respond_to(:whole_year?)
    period.whole_year?.should be_false
  end
  
  it "should return true to #whole_year? when it is Period.whole_year" do
    period = Period.whole_year
    period.should respond_to(:whole_year?)
    period.whole_year?.should be_true
  end
  
  it_should_behave_like "find existing records"
end
