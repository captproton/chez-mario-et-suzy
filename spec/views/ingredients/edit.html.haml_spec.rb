require File.dirname(__FILE__) + '/../../spec_helper'

describe "/ingredients/edit.html.haml" do
  include IngredientsHelper
  include ViewSpecHelper
  
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
    render "/ingredients/edit.html.haml"
    
    response.should have_tag("form[action=#{ingredient_category_ingredient_path(@ingredient_category, @ingredient)}][method=post]") do
      with_tag('input#ingredient_name[name=?]', "ingredient[name]")
    end
  end
end
