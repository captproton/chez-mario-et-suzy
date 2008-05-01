require File.dirname(__FILE__) + '/../../spec_helper'

describe "/units/index.html.haml" do
  include UnitsHelper
  
  before(:each) do
    unit_1 = mock_model(Unit, :id => 1)
    unit_1.should_receive(:name).and_return("Kilogrammes")
    unit_1.should_receive(:abbreviation).and_return("kg")
    unit_2 = mock_model(Unit, :id => 2)
    unit_2.should_receive(:name).and_return("Cups")
    unit_2.should_receive(:abbreviation).and_return("cp")

    assigns[:units] = [unit_1, unit_2]
  end

  def call_render
    render "/units/index.html.haml"
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
  
  it_should_behave_like "a page with a flash notice"
end
