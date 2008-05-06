require File.dirname(__FILE__) + '/../../spec_helper'

describe "/units/edit.html.haml" do
  include UnitsHelper
  include UnitSpecHelper
  include ViewSpecHelper
  
  def call_render
    render "/units/edit.html.haml", :layout => 'base'
  end
  
  describe "form block" do
    before do
      @unit = mock_model(Unit, :id => 1, :to_param => "1")
      @unit.stub!(:name).and_return("Kilogrammes")
      @unit.stub!(:abbreviation).and_return("kg")
      @errors = errors_mock_for(@unit)
      assigns[:unit] = @unit
    end

    it "should render edit form" do
      call_render
      response.should have_tag("form[action=/units/1][method=post]") do
        with_tag('input#unit_name[name=?]', "unit[name]")
        with_tag('input#unit_abbreviation[name=?]', "unit[abbreviation]")
        with_tag('input[type=submit]')
      end
    end
    
    it "should have a link back to units list" do
      call_render
      response.should have_tag("a[href=/units]")
    end
    
    it_should_behave_like "a page in the ingredients section"
  end
  
  describe "errors explanation block" do
    it_should_behave_like "a new/edit page with model errors"
  end
end
