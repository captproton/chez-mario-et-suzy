require File.dirname(__FILE__) + '/../../spec_helper'

describe "/ingredients/new.html.erb" do
  include IngredientsHelper
  include IngredientSpecHelper
  include ViewSpecHelper
  
  def call_render
    render "/ingredients/new.html.haml", :layout => 'base'
  end
  
  describe "form block" do
    before(:each) do
      @ingredient_category = mock_model(IngredientCategory, :to_param => "1")
      @ingredient = mock_model(Ingredient, :name => "", :unit_id => 1, :ingredient_category_id => 1, :period_id => 1)
      @ingredient.stub!(:new_record?).and_return(true)
      @errors = errors_mock_for(@ingredient)

      assigns[:ingredient] = @ingredient
      assigns[:ingredient_category] = @ingredient_category
      assigns[:units] = []
      assigns[:periods] = []
    end

    it "should render new form" do
      call_render
      response.should have_tag("form[action=/ingredient_categories/1/ingredients][method=post]") do
        with_tag("input#ingredient_name[name=?]", "ingredient[name]")
        with_tag('select#ingredient_unit_id[name=?]', "ingredient[unit_id]")
        with_tag('select#ingredient_period_id[name=?]', "ingredient[period_id]")
        with_tag("input[type=submit]")
      end
    end
    
    it "should have a link back to the ingredients list" do
      call_render
      response.should have_tag("a[href=/ingredient_categories/1/ingredients]")
    end
    
    it_should_behave_like "a page in the ingredients section"
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
