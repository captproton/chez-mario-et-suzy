require File.dirname(__FILE__) + '/../../spec_helper'

describe "/measures/edit.html.haml" do
  include MeasuresHelper
  include ViewSpecHelper
  
  before do
    @recipe_category = mock_model(RecipeCategory)
    @recipe = mock_model(Recipe)
    
    @measure = mock_model(Measure,
      :new_record? => false,
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

  it "should render edit form" do
    render "/measures/edit.html.haml"
    
    response.should have_tag("form[action=#{recipe_category_recipe_measure_path(@recipe_category, @recipe, @measure)}][method=post]") do
      with_tag('input#measure_number[name=?]', "measure[number]")
    end
  end
end
