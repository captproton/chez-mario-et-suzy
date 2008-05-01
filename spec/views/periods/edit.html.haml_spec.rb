require File.dirname(__FILE__) + '/../../spec_helper'

describe "/periods/edit.html.haml" do
  include PeriodsHelper
  include ViewSpecHelper
  
  before do
    @period = mock_model(Period, :start_month => 1, :end_month => 1)
    @errors = errors_mock_for(@period)
    assigns[:period] = @period
  end

  it "should render edit form" do
    render "/periods/edit.html.haml"
    
    response.should have_tag("form[action=#{period_path(@period)}][method=post]") do
      with_tag('select#period_start_month[name=?]', "period[start_month]")
      with_tag('select#period_end_month[name=?]', "period[end_month]")
    end
  end
end
