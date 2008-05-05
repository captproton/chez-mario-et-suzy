require File.dirname(__FILE__) + '/../../spec_helper'

describe "/periods/edit.html.haml" do
  include PeriodsHelper
  include PeriodSpecHelper
  include ViewSpecHelper
  
  def call_render
    render "/periods/edit.html.haml", :layout => 'base'
  end
  
  describe "form block" do
    before do
      @period = mock_model(Period, :start_month => 1, :end_month => 1, :id => 1, :to_param => "1")
      @errors = errors_mock_for(@period)
      assigns[:period] = @period
    end

    it "should render edit form" do
      call_render
      response.should have_tag("form[action=/periods/1][method=post]") do
        with_tag('select#period_start_month[name=?]', "period[start_month]")
        with_tag('select#period_end_month[name=?]', "period[end_month]")
        with_tag('input[type=submit]')
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
