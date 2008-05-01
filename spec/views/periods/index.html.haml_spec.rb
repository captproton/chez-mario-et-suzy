require File.dirname(__FILE__) + '/../../spec_helper'

describe "/periods/index.html.haml" do
  include PeriodsHelper
  include GLoc
  
  before(:each) do
    period_1 = mock_model(Period, :id => 1)
    period_1.should_receive(:start_month_symbol).and_return(:february)
    period_1.should_receive(:end_month_symbol).and_return(:june)
    period_2 = mock_model(Period, :id => 2)
    period_2.should_receive(:start_month_symbol).and_return(:january)
    period_2.should_receive(:end_month_symbol).and_return(:december)

    assigns[:periods] = [period_1, period_2]
  end
  
  def call_render
    render "/periods/index.html.haml"
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
  
  it_should_behave_like "a page with a flash notice"
end
