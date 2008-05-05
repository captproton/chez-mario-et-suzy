require File.dirname(__FILE__) + '/../../spec_helper'

describe "/periods/new.html.haml" do
  include PeriodsHelper
  include PeriodSpecHelper
  include ViewSpecHelper
  
  def call_render
    render "/periods/new.html.haml", :layout => 'base'
  end
  
  describe "form block" do
    before(:each) do
      @period = mock_model(Period, :start_month => 1, :end_month => 1)
      @period.stub!(:new_record?).and_return(true)
      @errors = errors_mock_for(@period)
      assigns[:period] = @period
    end

    it "should render new form" do
      call_render
      response.should have_tag("form[action=/periods][method=post]") do
        with_tag("select#period_start_month[name=?]", "period[start_month]")
        with_tag("select#period_end_month[name=?]", "period[end_month]")
        with_tag("input[type=submit]")
      end
    end
    
    it "should have a link back to periods list" do
      call_render
      response.should have_tag("a[href=/periods]")
    end
  end
  
  describe "errors explanation block" do
    it_should_behave_like "a new/edit page with model errors"
  end
end
