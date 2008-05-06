require File.dirname(__FILE__) + '/../../spec_helper'

describe "/measures/edit.html.haml" do
  include MeasuresHelper
  include MeasureSpecHelper
  include ViewSpecHelper
  
  def call_render
    render "/measures/edit.html.haml", :layout => 'base'
  end
  
  describe "form block" do
    before do
      @recipe_category = mock_model(RecipeCategory, :to_param => "1")
      @recipe = mock_model(Recipe, :to_param => "1")
    
      @measure = mock_model(Measure,
        :new_record? => false,
        :number => 3,
        :recipe_id => 1,
        :ingredient_id => 1,
        :id => 1,
        :to_param => "1"
      )
      @errors = errors_mock_for(@measure)
    
      assigns[:recipe_category] = @recipe_category
      assigns[:recipe] = @recipe
      assigns[:measure] = @measure
      assigns[:ingredients] = []
    end

    it "should render edit form" do
      call_render
      response.should have_tag("form[action=/recipe_categories/1/recipes/1/measures/1][method=post]") do
        with_tag('input#measure_number[name=?]', "measure[number]")
        with_tag('select#measure_ingredient_id[name=?]', "measure[ingredient_id]")
        with_tag('input[type=submit]')
      end
    end
    
    it "should have a link back to measures list" do
      call_render
      response.should have_tag("a[href=/recipe_categories/1/recipes/1/measures]")
    end
    
    it_should_behave_like "a page in the recipes section"
  end
  
  describe "error explanation block" do
    before(:each) do
      assigns[:recipe_category] = mock_model(RecipeCategory)
      assigns[:recipe] = mock_model(Recipe)
      assigns[:ingredients] = []
    end
    it_should_behave_like "a new/edit page with model errors"
  end
end
