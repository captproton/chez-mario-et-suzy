require File.dirname(__FILE__) + '/../../spec_helper'

describe "/periods/new.html.haml" do
  include PeriodsHelper
  include ViewSpecHelper
  
  before(:each) do
    @period = mock_model(Period, :start_month => 1, :end_month => 1)
    @period.stub!(:new_record?).and_return(true)
    @errors = errors_mock_for(@period)
    assigns[:period] = @period
  end

  it "should render new form" do
    render "/periods/new.html.haml"
    
    response.should have_tag("form[action=?][method=post]", periods_path) do
      with_tag("select#period_start_month[name=?]", "period[start_month]")
      with_tag("select#period_end_month[name=?]", "period[end_month]")
    end
  end
end
