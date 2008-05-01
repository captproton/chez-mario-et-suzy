require File.dirname(__FILE__) + '/../../spec_helper'

describe "/ingredients/index.html.haml" do
  include IngredientsHelper
  include GLoc
  
  before(:each) do
    ingredient_category = mock_model(IngredientCategory, :name => "Vegetables")
    
    ingredient_1 = mock_model(Ingredient, :id => 1)
    ingredient_1.should_receive(:name).and_return("Carrots")
    unit_1 = mock_model(Unit, :none? => false, :abbreviation => "kg")
    ingredient_1.should_receive(:unit).at_least(:once).and_return(unit_1)
    period_1 = mock_model(Period, :whole_year? => false, :start_month_symbol => :january, :end_month_symbol => :march)
    ingredient_1.should_receive(:period).at_least(:once).and_return(period_1)
    
    ingredient_2 = mock_model(Ingredient, :id => 2)
    ingredient_2.should_receive(:name).and_return("Lemons")
    unit_2 = mock_model(Unit, :none? => true)
    ingredient_2.should_receive(:unit).at_least(:once).and_return(unit_2)
    period_2 = mock_model(Period, :whole_year? => true)
    ingredient_2.should_receive(:period).at_least(:once).and_return(period_2)

    assigns[:ingredient_category] = ingredient_category
    assigns[:ingredients] = [ingredient_1, ingredient_2]
  end

  def call_render
    render "/ingredients/index.html.haml"
  end

  it "should render list of ingredients with unit abbreviation and period months when necessary" do
    call_render
    response.should have_tag("div#ingredient_1.ingredient") do
      with_tag("h3", /Carrots/)
      with_tag("p.ingredient_unit", /kg/)
      with_tag("p.ingredient_period", /#{l(:label_month_january)}.*#{l(:label_month_march)}/)
    end
    response.should have_tag("div#ingredient_2.ingredient") do
      with_tag("h3", /Lemons/)
      without_tag("p.ingredient_unit")
      without_tag("p.ingredient_period")
    end
  end
  
  it_should_behave_like "a page with a flash notice"
end