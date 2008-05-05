require File.dirname(__FILE__) + '/../../spec_helper'

describe "/ingredients/edit.html.haml" do
  include IngredientsHelper
  include IngredientSpecHelper
  include ViewSpecHelper
  
  def call_render
    render "/ingredients/edit.html.haml", :layout => 'base'
  end
  
  describe "form block" do
    before do
      @ingredient_category = mock_model(IngredientCategory, :to_param => "1")
      @ingredient = mock_model(Ingredient, :name => "", :unit_id => 1, :ingredient_category_id => 1, :period_id => 1, :to_param => "1")
      @ingredient.stub!(:new_record?).and_return(false)
      @errors = errors_mock_for(@ingredient)

      assigns[:ingredient] = @ingredient
      assigns[:ingredient_category] = @ingredient_category
      assigns[:units] = []
      assigns[:periods] = []
    end

    it "should render edit form" do
      call_render
      response.should have_tag("form[action=/ingredient_categories/1/ingredients/1][method=post]") do
        with_tag('input#ingredient_name[name=?]', "ingredient[name]")
        with_tag('select#ingredient_unit_id[name=?]', "ingredient[unit_id]")
        with_tag('select#ingredient_period_id[name=?]', "ingredient[period_id]")
        with_tag("input[type=submit]")
      end
    end
    
    it "should have a link back to ingredients list" do
      call_render
      response.should have_tag("a[href=/ingredient_categories/1/ingredients]")
    end
  end
  
  describe "error explanation block" do
    before(:each) do
      assigns[:ingredient_category] = mock_model(IngredientCategory)
      assigns[:units] = []
      assigns[:periods] = []
    end
    it_should_behave_like "a new/edit page with model errors"
  end
end
