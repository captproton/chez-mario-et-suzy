require File.dirname(__FILE__) + '/../../spec_helper'

describe "/units/index.html.haml" do
  include UnitsHelper
  include ViewSpecHelper
  
  before(:each) do
    unit_1 = mock_model(Unit, :id => 1, :to_param => "1")
    unit_1.should_receive(:name).and_return("Kilogrammes")
    unit_1.should_receive(:abbreviation).and_return("kg")
    unit_2 = mock_model(Unit, :id => 2, :to_param => "2")
    unit_2.should_receive(:name).and_return("Cups")
    unit_2.should_receive(:abbreviation).and_return("cp")
    
    # This unit should be on page 2
    unit_3 = mock_model(Unit)

    assigns[:units] = [unit_1, unit_2, unit_3].paginate(:per_page => 2)
  end

  def call_render
    render "/units/index.html.haml", :layout => 'base'
  end

  it "should render list of units" do
    call_render
    response.should have_tag("div#unit_1.unit") do
      with_tag("h3", /Kilogrammes/) do
        with_tag("span", /kg/)
      end
    end
    response.should have_tag("div#unit_2.unit") do
      with_tag("h3", /Cups/) do
        with_tag("span", /cp/)
      end
    end
  end
  
  it "should not render the third unit which is on next page" do
    call_render
    response.should have_tag("div.unit", 2)
  end
  
  it "should render an edit link for each unit" do
    call_render
    response.should have_tag("div#unit_1") do
      with_tag("a[href=/units/1/edit]")
    end
    response.should have_tag("div#unit_2") do
      with_tag("a[href=/units/2/edit]")
    end
  end
  
  it "should render a delete link for each unit" do
    call_render
    response.should have_tag("div#unit_1") do
      with_tag("a[href=/units/1][onclick=?]", delete_link_pattern)
    end
    response.should have_tag("div#unit_2") do
      with_tag("a[href=/units/2][onclick=?]", delete_link_pattern)
    end
  end
  
  it "should render the pagination block" do
    call_render
    response.should have_tag("div.pagination")
  end
  
  it "should have a link for creating a new unit" do
    call_render
    response.should have_tag("a[href=/units/new]")
  end
  
  it_should_behave_like "a page in the ingredients section"
  
  it_should_behave_like "a page with a flash notice"
end
