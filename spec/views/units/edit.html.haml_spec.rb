require File.dirname(__FILE__) + '/../../spec_helper'

describe "/units/edit.html.haml" do
  include UnitsHelper
  include ViewSpecHelper
  
  before do
    @unit = mock_model(Unit)
    @unit.stub!(:name).and_return("Kilogrammes")
    @unit.stub!(:abbreviation).and_return("kg")
    @errors = errors_mock_for(@unit)
    assigns[:unit] = @unit
  end

  it "should render edit form" do
    render "/units/edit.html.haml"
    
    response.should have_tag("form[action=#{unit_path(@unit)}][method=post]") do
      with_tag('input#unit_name[name=?]', "unit[name]")
      with_tag('input#unit_abbreviation[name=?]', "unit[abbreviation]")
    end
  end
end
