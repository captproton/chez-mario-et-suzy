require File.dirname(__FILE__) + '/../../spec_helper'

describe "/measures/new.html.haml" do
  include MeasuresHelper
  include ViewSpecHelper
  
  before(:each) do
    @recipe_category = mock_model(RecipeCategory)
    @recipe = mock_model(Recipe)
    
    @measure = mock_model(Measure,
      :new_record? => true,
      :number => 3,
      :recipe_id => 1,
      :ingredient_id => 1
    )
    @errors = errors_mock_for(@measure)
    
    assigns[:recipe_category] = @recipe_category
    assigns[:recipe] = @recipe
    assigns[:measure] = @measure
    assigns[:ingredients] = []
  end

  it "should render new form" do
    render "/measures/new.html.haml"
    response.should have_tag("form[action=?][method=post]", recipe_category_recipe_measures_path(@recipe_category, @recipe)) do
      with_tag("input#measure_number[name=?]", "measure[number]")
    end
  end
end
