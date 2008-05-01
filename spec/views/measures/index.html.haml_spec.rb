require File.dirname(__FILE__) + '/../../spec_helper'

describe "/measures/index.html.haml" do
  include MeasuresHelper
  
  before(:each) do
    recipe_category = mock_model(RecipeCategory)
    recipe = mock_model(Recipe, :name => "Sauteed beef")
    
    unit_1 = mock_model(Unit, :none? => false, :abbreviation => "kg")
    ingredient_1 = mock_model(Ingredient, :name => "Beef", :unit => unit_1)
    measure_1 = mock_model(Measure, :id => 1, :number => 3, :ingredient => ingredient_1)
    
    unit_2 = mock_model(Unit, :none? => true)
    ingredient_2 = mock_model(Ingredient, :name => "Carrots", :unit => unit_2)
    measure_2 = mock_model(Measure, :id => 2, :number => 15, :ingredient => ingredient_2)

    assigns[:recipe_category] = recipe_category
    assigns[:recipe] = recipe
    assigns[:measures] = [measure_1, measure_2]
  end

  def call_render
    render "/measures/index.html.haml"
  end

  it "should render list of measures" do
    call_render
    response.should have_tag("div#measure_1.measure") do
      with_tag("h3", /3kg Beef/)
    end
    response.should have_tag("div#measure_2.measure") do
      with_tag("h3", /15 Carrots/)
    end
  end
  
  it_should_behave_like "a page with a flash notice"
end
