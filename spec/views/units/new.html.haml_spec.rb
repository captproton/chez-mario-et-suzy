require File.dirname(__FILE__) + '/../../spec_helper'

describe "/units/new.html.haml" do
  include UnitsHelper
  include ViewSpecHelper
  
  before(:each) do
    @unit = mock_model(Unit, :name => "", :abbreviation => "")
    @unit.stub!(:new_record?).and_return(true)
    @errors = errors_mock_for(@unit)
    assigns[:unit] = @unit
  end

  it "should render new form" do
    render "/units/new.html.haml"
    
    response.should have_tag("form[action=?][method=post]", units_path) do
      with_tag("input#unit_name[name=?]", "unit[name]")
      with_tag("input#unit_abbreviation[name=?]", "unit[abbreviation]")
    end
  end
end
