require File.dirname(__FILE__) + '/../../spec_helper'

describe "/periods/index.html.haml" do
  include PeriodsHelper
  include ViewSpecHelper
  include GLoc
  
  before(:each) do
    period_1 = mock_model(Period, :id => 1, :to_param => "1")
    period_1.should_receive(:start_month_symbol).and_return(:february)
    period_1.should_receive(:end_month_symbol).and_return(:june)
    period_2 = mock_model(Period, :id => 2, :to_param => "2")
    period_2.should_receive(:start_month_symbol).and_return(:january)
    period_2.should_receive(:end_month_symbol).and_return(:december)

    assigns[:periods] = [period_1, period_2]
  end
  
  def call_render
    render "/periods/index.html.haml", :layout => 'base'
  end

  it "should render list of periods" do
    call_render
    response.should have_tag("div#period_1.period") do
      with_tag("h3", /#{l(:label_month_february)}.*#{l(:label_month_june)}/)
    end
    response.should have_tag("div#period_2.period") do
      with_tag("h3", /#{l(:label_month_january)}.*#{l(:label_month_december)}/)
    end
  end
  
  it "should render an edit link for each period" do
    call_render
    response.should have_tag("div#period_1") do
      with_tag("a[href=/periods/1/edit]")
    end
    response.should have_tag("div#period_2") do
      with_tag("a[href=/periods/2/edit]")
    end
  end
  
  it "should render a delete link for each period" do
    call_render
    response.should have_tag("div#period_1") do
      with_tag("a[href=/periods/1][onclick=?]", delete_link_pattern)
    end
    response.should have_tag("div#period_2") do
      with_tag("a[href=/periods/2][onclick=?]", delete_link_pattern)
    end
  end
  
  it "should have a link for creating a new period" do
    call_render
    response.should have_tag("a[href=/periods/new]")
  end
  
  it_should_behave_like "a page in the ingredients section"
  
  it_should_behave_like "a page with a flash notice"
end
